#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ $# -eq 0 ]; then
    >&2 echo "Usage: $0 <Vim version on https://github.com/vim/vim/tags>"
    exit 1
fi
VERSION=$1

TMP_DIR=$(mktemp -d)
trap 'rm -rf "${TMP_DIR}"' EXIT

cd "${TMP_DIR}"

# Remove any pre-existing packaged vim so it does not shadow our build.
sudo dnf remove -y vim-enhanced vim-minimal 2>/dev/null || true

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
