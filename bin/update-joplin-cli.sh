#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Short-circuit: query the latest published Joplin version and skip the full
# npm reinstall if the installed version already matches. `npm view` is a
# cheap metadata call versus the ~2 minute npm install of a deep dependency
# tree.
#
# Check the REAL npm-installed binary (~/.joplin-bin/bin/joplin), NOT the
# ~/bin/joplin symlink. The symlink is created by deploy-part-2.sh after this
# script runs, so on a fresh (or re-run) box it may not exist yet, which made
# the previous guard always skip and triggered a full reinstall every time.
JOPLIN_BIN="${HOME}/.joplin-bin/bin/joplin"
if [[ -x "${JOPLIN_BIN}" ]]; then
    INSTALLED="$("${JOPLIN_BIN}" version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n1 || true)"
    LATEST="$(npm view joplin version 2>/dev/null || true)"
    if [[ -n "${INSTALLED}" && -n "${LATEST}" && "${INSTALLED}" == "${LATEST}" ]]; then
        echo "Joplin CLI ${INSTALLED} already current (latest ${LATEST}); skipping install."
        exit 0
    fi
fi

sudo rm -rf "${HOME}/.joplin-bin"
sudo dnf install -y fuse-libs

# NOTE: use ${HOME} everywhere (never a bare `~`) — tilde does NOT expand in an
# environment-assignment position (`VAR=~/x cmd`), so `NPM_CONFIG_PREFIX=~/...`
# would install into a literal tilde dir and break both the skip guard and the
# symlink target.
NPM_CONFIG_PREFIX="${HOME}/.joplin-bin" npm install -g joplin
cd "${HOME}/.joplin-bin/lib/node_modules/joplin/"
npm install --cpu=x64 --platform=linux sharp
cd "${HOME}/.joplin-bin/lib/node_modules/joplin/node_modules/@joplin/tools"
npm install --cpu=x64 --platform=linux sharp
ln -sf "${HOME}/.joplin-bin/bin/joplin" "${HOME}/bin/joplin"

