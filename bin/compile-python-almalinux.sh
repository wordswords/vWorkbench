#!/usr/bin/env bash

set -euo pipefail

sudo dnf update -y
sudo dnf install -y gcc make wget tar openssl-devel bzip2-devel libffi-devel zlib-devel sqlite-devel readline-devel ncurses-devel xz-devel tk-devel gdbm-devel

cd /tmp
wget https://www.python.org/ftp/python/3.12.0/Python-3.12.0.tgz
tar -xf Python-3.12.0.tgz
cd Python-3.12.0
./configure --enable-shared
make -j "$(nproc)"
sudo make altinstall
echo "/usr/local/lib" | sudo tee /etc/ld.so.conf.d/python3.12.conf
sudo ldconfig

