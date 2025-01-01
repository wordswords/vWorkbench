#!/bin/bash

set -x
set -e

if [ $# -eq 0 ]; then
    >&2 echo "Usage: $0 <Vim verison on https://mirrorservice.org/pub/vim/unix/>"
    exit 1
fi
VERSION=$1

TMP_DIR=$(mktemp -d)
cd "${TMP_DIR}"
sudo apt remove vim vim-gtk3 vim-tiny -y
sudo apt install libxt-dev=1:1.2.1-1 --allow-downgrades -y
sudo apt install libpython3-dev=3.10.6-1~22.04.1 --allow-downgrades -y
sudo apt install libncurses-dev=6.3-2ubuntu0.1 --allow-downgrades -y
wget https://github.com/vim/vim/archive/refs/tags/v$1.tar.gz
tar zxf v*gz
rm ./*tar | true
rm ./*bz2* | true
cd ./vim*
make clean dist clean
./configure --enable-python3interp=yes --with-python3-command=/bin/python3 --with-python3-config-dir="$(python3-config --configdir)"
make -j
sudo make install
cd ..
rm -rf "${TMP_DIR}"

