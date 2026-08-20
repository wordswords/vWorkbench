#!/usr/bin/env bash

set -euo pipefail

# PYTHON_VERSION can be set via the environment (exported by deploy.sh) or as
# the first positional argument; defaults to 3.12.0.
PYTHON_VERSION="${PYTHON_VERSION:-${1:-3.12.0}}"

sudo dnf update -y
sudo dnf install -y gcc make wget tar openssl-devel bzip2-devel libffi-devel zlib-devel sqlite-devel readline-devel ncurses-devel xz-devel tk-devel gdbm-devel

cd /tmp
wget "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz"
tar -xf "Python-${PYTHON_VERSION}.tgz"
cd "Python-${PYTHON_VERSION}"
./configure --enable-shared
make -j "$(nproc)"
sudo make altinstall
echo "/usr/local/lib" | sudo tee "/etc/ld.so.conf.d/python${PYTHON_VERSION%.*}.conf"
sudo ldconfig
