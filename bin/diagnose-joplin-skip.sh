#!/usr/bin/env bash
# Diagnose why the Joplin CLI skip-if-current guard does not fire.
#
# This script emits the exact facts the guard in update-joplin-cli.sh relies
# on, so a failed skip can be traced to a specific value. Run it on the target
# machine and share the output.
set -uo pipefail

echo "== Diagnostics: Joplin CLI skip guard =="
echo

echo "HOME                     = ${HOME}"
echo "JOPLIN_BIN (real)        = ${HOME}/.joplin-bin/bin/joplin"
echo "JOPLIN_SYMLINK (~/bin)   = ${HOME}/bin/joplin"

echo
echo "-- Real npm-installed binary (~/.joplin-bin/bin/joplin) --"
if [[ -e "${HOME}/.joplin-bin/bin/joplin" ]]; then
    echo "exists                  : yes"
    echo "executable              : $([[ -x "${HOME}/.joplin-bin/bin/joplin" ]] && echo yes || echo no)"
    echo "type                    : $(file -b "${HOME}/.joplin-bin/bin/joplin" 2>/dev/null || echo unknown)"
else
    echo "exists                  : NO"
fi

echo
echo "-- ~/bin/joplin symlink --"
if [[ -e "${HOME}/bin/joplin" ]]; then
    echo "exists                  : yes"
    echo "is symlink              : $([[ -L "${HOME}/bin/joplin" ]] && echo yes || echo no)"
    echo "resolves to             : $(readlink -f "${HOME}/bin/joplin" 2>/dev/null)"
    echo "executable              : $([[ -x "${HOME}/bin/joplin" ]] && echo yes || echo no)"
else
    echo "exists                  : NO"
fi

echo
echo "-- 'joplin version' / 'joplin --version' raw output --"
for b in "${HOME}/.joplin-bin/bin/joplin" "${HOME}/bin/joplin"; do
    if [[ -x "${b}" ]]; then
        echo "binary: ${b}"
        echo "  \"version\"   -> $("${b}" version 2>&1 | head -n1)"
        echo "  \"--version\" -> $("${b}" --version 2>&1 | head -n1)"
        echo "  \"-v\"        -> $("${b}" -v 2>&1 | head -n1)"
    fi
done

echo
echo "-- Parsed INSTALLED (grep -oE '[0-9]+\\.[0-9]+\\.[0-9]+' | head -n1) --"
INSTALLED="$("${HOME}/.joplin-bin/bin/joplin" version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n1 || true)"
echo "INSTALLED = '${INSTALLED}'"
# Show the literal command used, in case the binary path is empty.
echo "(raw \$HOME expansion check) HOME=.joplin-bin present? $([[ -d "${HOME}/.joplin-bin" ]] && echo yes || echo no)"

echo
echo "-- npm availability & 'npm view joplin version' --"
echo "npm path                : $(command -v npm || echo 'NOT FOUND')"
echo "npm version             : $(npm --version 2>/dev/null || echo 'unavailable')"
LATEST="$(npm view joplin version 2>&1 || true)"
echo "npm view joplin version : ${LATEST}"
LATEST_PARSED="$(npm view joplin version 2>/dev/null || true)"
echo "LATEST (parsed)         = '${LATEST_PARSED}'"

echo
echo "-- Comparison the guard performs --"
echo "INSTALLED = '${INSTALLED}'"
echo "LATEST    = '${LATEST_PARSED}'"
if [[ -n "${INSTALLED}" && -n "${LATEST_PARSED}" && "${INSTALLED}" == "${LATEST_PARSED}" ]]; then
    echo "VERDICT: would SKIP (match)"
else
    echo "VERDICT: would NOT skip. Reasons:"
    [[ -z "${INSTALLED}" ]] && echo "  - INSTALLED is empty (binary/version output parse failed)"
    [[ -z "${LATEST_PARSED}" ]] && echo "  - LATEST is empty (npm view failed / no network / npm missing)"
    [[ -n "${INSTALLED}" && -n "${LATEST_PARSED}" && "${INSTALLED}" != "${LATEST_PARSED}" ]] \
        && echo "  - version mismatch: installed ${INSTALLED} != latest ${LATEST_PARSED}"
fi
