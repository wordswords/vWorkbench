#!/usr/bin/env bash

set -euo pipefail

# Build a self-contained Python from source and install it via `make
# altinstall` to /usr/local/bin/pythonX.Y, WITHOUT installing any shared
# libpython into the global library search path and WITHOUT creating a bare
# `python3`/`python` symlink.
#
# Why this matters:
#   - AlmaLinux 10 already ships Python 3.12 as the system `python3`. Building
#     another 3.12 and adding /usr/local/lib to ld.so.conf.d makes the loader
#     prefer our libpython3.12.so.1.0 over the distro's, breaking `dnf`
#     (the system `python3 -s` then can no longer import the `dnf` module).
#   - We therefore (1) skip the build entirely if the system interpreter is
#     already new enough, (2) build a STATIC interpreter (no --enable-shared)
#     so no libpython is installed at all, and (3) never touch ld.so.conf.d.

# PYTHON_VERSION can be set via the environment (exported by deploy.sh) or as
# the first positional argument; the version we *need* (must be >= this).
PYTHON_VERSION="${PYTHON_VERSION:-${1:-3.12.0}}"

# `make altinstall` installs this as e.g. /usr/local/bin/python3.12.
TARGET_BIN="/usr/local/bin/python${PYTHON_VERSION%.*}"

need_python() {
    # Returns 0 if $1 is an executable interpreter reporting a version that is
    # >= PYTHON_VERSION (by simple numeric dotted comparison). Uses no imports,
    # so it works even if site-packages (dnf) would be missing.
    local candidate="$1"
    [[ -x "${candidate}" ]] || return 1
    local actual
    actual="$("${candidate}" -c 'import sys;print(sys.version_info[0],sys.version_info[1])' 2>/dev/null)" || return 1
    local need_major need_minor
    need_major="${PYTHON_VERSION%%.*}"
    need_minor="$(echo "${PYTHON_VERSION}" | awk -F. '{print $2}')"
    local a_major a_minor
    a_major="${actual%% *}"
    a_minor="${actual##* }"
    if (( a_major > need_major )) || { (( a_major == need_major )) && (( a_minor >= need_minor )); }; then
        return 0
    fi
    return 1
}

# 1. Short-circuit if our exact built interpreter is already present.
if [[ -x "${TARGET_BIN}" ]]; then
    echo "Python ${PYTHON_VERSION} already installed at ${TARGET_BIN}; skipping build."
    exit 0
fi

# 2. Short-circuit if the system `python3` already satisfies the requirement
#    (e.g. AlmaLinux 10 ships 3.12). Building a duplicate would only risk
#    shadowing the system libpython and breaking dnf.
if need_python /usr/bin/python3; then
    echo "System python3 already satisfies >= ${PYTHON_VERSION}; skipping source build."
    echo "(No /usr/local Python will be created. Consumers should use the system python3.)"
    exit 0
fi

sudo dnf install -y -q gcc make wget tar \
    openssl-devel bzip2-devel libffi-devel zlib-devel sqlite-devel \
    readline-devel ncurses-devel xz-devel tk-devel gdbm-devel \
    libuuid-devel libnsl-devel

TMP_DIR="$(mktemp -d)"
# `sudo make altinstall` generates root-owned .pyc files in the source tree,
# so the cleanup must also run as root to avoid a flood of "Permission denied"
# and a non-zero exit with `set -e`.
trap 'sudo rm -rf "${TMP_DIR}"' EXIT
cd "${TMP_DIR}"

wget "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz"
tar -xf "Python-${PYTHON_VERSION}.tgz"
cd "Python-${PYTHON_VERSION}"

# Deliberately NO --enable-shared: a static interpreter has no libpython*.so.1.0
# to install, so it cannot shadow the distro's shared library and break dnf.
./configure
make -j "$(nproc)"
sudo make altinstall

# NOTE: We intentionally do NOT drop an /etc/ld.so.conf.d entry or run
# ldconfig. Those steps were the cause of the dnf outage.
