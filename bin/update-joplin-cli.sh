#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Short-circuit: query the latest published Joplin version and skip the full
# npm reinstall if the installed version already matches.
#
# We read the version from the npm-installed package.json rather than running
# the joplin binary: the binary (a symlink/path to main.js) has historically
# failed with "Cannot find module '../package.json'" and doesn't expose a
# reliable --version flag, which made the guard unreliable.
JOPLIN_PKG_JSON="${HOME}/.joplin-bin/lib/node_modules/joplin/package.json"
if [[ -f "${JOPLIN_PKG_JSON}" ]]; then
    INSTALLED="$(grep -m1 '"version"' "${JOPLIN_PKG_JSON}" 2>/dev/null \
        | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n1 || true)"
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

