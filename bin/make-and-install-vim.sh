#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ $# -eq 0 ]; then
    >&2 echo "Usage: $0 <Vim version on https://github.com/vim/vim/tags>"
    exit 1
fi
VERSION=$1

# Short-circuit: if the requested major.minor is already installed, skip the
# ~1.5 minute source build. `vim --version` reports e.g. "9.2" while VERSION
# is a full tag like "9.2.0272", so compare the major.minor only. We check
# /usr/local/bin/vim specifically because that is where `make install` puts
# the binary we build here (the distro's /usr/bin/vim may be a different,
# older version).
# Strip a single trailing ".patch" component to get major.minor (9.2.0272 -> 9.2).
WANTED_MJ="${VERSION%.*}"
if [[ -x /usr/local/bin/vim ]]; then
    INSTALLED="$(/usr/local/bin/vim --clean --version 2>/dev/null | head -n1 | grep -oE '[0-9]+\.[0-9]+' | head -n1)"
    if [[ "${INSTALLED}" == "${WANTED_MJ}" ]]; then
        echo "Vim ${WANTED_MJ} already installed at /usr/local/bin/vim; skipping build."
        exit 0
    fi
fi

TMP_DIR=$(mktemp -d)
trap 'rm -rf "${TMP_DIR}"' EXIT

cd "${TMP_DIR}"

sudo dnf install -y make gcc gcc-c++ git python3-devel ncurses-devel

wget "https://github.com/vim/vim/archive/refs/tags/v${VERSION}.tar.gz"
tar xzf "v${VERSION}.tar.gz"
rm "v${VERSION}.tar.gz"

cd "vim-${VERSION}"
make clean dist clean || true

./configure \
    --enable-python3interp=yes \
    --with-python3-command=/bin/python3 \
    --with-python3-config-dir="$(python3-config --configdir)"

make -j
sudo make install
