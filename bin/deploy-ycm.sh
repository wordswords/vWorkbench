#!/usr/bin/env bash
# Install YouCompleteMe prerequisites and compile the plugin.
# Assumes node is already installed.

set -euo pipefail
IFS=$'\n\t'

readonly YCM_DIR="$HOME/.vim/bundle/YouCompleteMe"

# YouCompleteMe requires Python >= 3.12.0. AlmaLinux 9 only ships Python 3.9
# as `python3`, so we must locate (or have previously built) a 3.12+ binary.
# `compile-python-almalinux.sh` installs one to /usr/local/bin/python3.12.
YCM_PYTHON="${YCM_PYTHON:-}"
if [[ -n "${YCM_PYTHON}" ]]; then
    : # explicit override
elif [[ -x /usr/local/bin/python3.12 ]]; then
    YCM_PYTHON="/usr/local/bin/python3.12"
elif command -v python3.12 >/dev/null 2>&1; then
    YCM_PYTHON="$(command -v python3.12)"
elif command -v python3.13 >/dev/null 2>&1; then
    YCM_PYTHON="$(command -v python3.13)"
elif command -v python3.14 >/dev/null 2>&1; then
    YCM_PYTHON="$(command -v python3.14)"
else
    echo "ERROR: YouCompleteMe needs Python >= 3.12, but none was found on PATH." >&2
    echo "       Install one first, e.g. run ~/.dotfiles/bin/compile-python-almalinux.sh" \
        "       (builds python3.12 to /usr/local/bin), or set YCM_PYTHON." >&2
    exit 1
fi
echo "Using Python for YCM: ${YCM_PYTHON} ($("${YCM_PYTHON}" --version 2>&1))"

# Short-circuit: if YouCompleteMe is already cloned and its native ycm_core
# module compiled, skip the ~3.5 minute clone + submodule + compile. The
# compiled shared library is named ycm_core*.so; its exact path differs by
# ycmd version, so search the whole ycmd tree for any of them.
if [[ -d "${YCM_DIR}/third_party/ycmd/.git" ]] \
   && find "${YCM_DIR}/third_party/ycmd" -name 'ycm_core*.so' -print -quit 2>/dev/null | grep -q .; then
    echo "YouCompleteMe already built at ${YCM_DIR}; skipping clone and compile."
    exit 0
fi

# System prerequisites.
sudo dnf install -y mono-complete golang
sudo dnf install -y java-latest-openjdk java-latest-openjdk-devel

# Prerequisites for building ycmd's optional C extensions (the `regex` module
# used for faster fuzzy matching, and the `watchdog` module). Without these,
# build.py silently falls back to the slower pure-Python `re` builtin:
#   - gcc + make: compile the .c sources via setup.py build
#   - python3.12-devel (or matching pythonX.Y-devel): provides Python.h for the
#     interpreter that runs install.py
#   - setuptools: imported by build.py to drive the C extension build
sudo dnf install -y gcc make python3-devel python3-setuptools

# Fetch a fresh copy of YouCompleteMe.
rm -rf "${YCM_DIR}"
mkdir -p "${YCM_DIR}"
git clone git@github.com:ycm-core/YouCompleteMe.git "${YCM_DIR}"

# Compile semantic completers.
(
    cd "${YCM_DIR}"
    git submodule update --init --recursive
    "${YCM_PYTHON}" install.py --cs-completer --ts-completer --rust-completer --java-completer
)
