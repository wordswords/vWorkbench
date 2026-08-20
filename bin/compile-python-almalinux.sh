#!/usr/bin/env bash

set -euo pipefail

# PYTHON_VERSION can be set via the environment (exported by deploy.sh) or as
# the first positional argument; defaults to 3.12.0.
PYTHON_VERSION="${PYTHON_VERSION:-${1:-3.12.0}}"

# `make altinstall` installs this as e.g. /usr/local/bin/python3.12.
TARGET_BIN="/usr/local/bin/python${PYTHON_VERSION%.*}"

# Short-circuit: skip the ~5 minute source build if this exact interpreter is
# already installed.
if [[ -x "${TARGET_BIN}" ]]; then
    echo "Python ${PYTHON_VERSION} already installed at ${TARGET_BIN}; skipping build."
    exit 0
fi

sudo dnf install -y -q gcc make wget tar \
    openssl-devel bzip2-devel libffi-devel zlib-devel sqlite-devel \
    readline-devel ncurses-devel xz-devel tk-devel gdbm-devel

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT
cd "${TMP_DIR}"

wget "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz"
tar -xf "Python-${PYTHON_VERSION}.tgz"
cd "Python-${PYTHON_VERSION}"
./configure --enable-shared
make -j "$(nproc)"
sudo make altinstall
echo "/usr/local/lib" | sudo tee "/etc/ld.so.conf.d/python${PYTHON_VERSION%.*}.conf"
sudo ldconfig
