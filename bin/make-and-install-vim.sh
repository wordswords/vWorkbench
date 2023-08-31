#!/bin/bash

set -x
set -e
VERSION="9.0"

TMP_DIR=$(mktemp -d)
cd "${TMP_DIR}"
sudo apt install libxt-dev libpython3-dev -y
wget https://www.mirrorservice.org/pub/vim/unix/vim-${VERSION}.tar.bz2
bunzip2 vim*bz2
tar xf vim*tar
rm ./*tar | true
rm ./*bz2* | true
cd ./vim*
make clean dist clean
./configure --enable-python3interp=yes --with-python3-command=/bin/python3 --with-python3-config-dir="$(python3-config --configdir)"
make -j
sudo make install
cd ..
rm -rf "${TMP_DIR}"

