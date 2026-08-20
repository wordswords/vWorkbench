#!/usr/bin/env bash
# Install YouCompleteMe prerequisites and compile the plugin.
# Assumes node is already installed.

set -euo pipefail
IFS=$'\n\t'

readonly YCM_DIR="$HOME/.vim/bundle/YouCompleteMe"

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
#   - python3-devel: provides Python.h and matching headers for the same
#     interpreter that runs install.py
#   - python3-devel: provides Python.h and matching headers for the same
#     interpreter that runs install.py
#   - python3-setuptools: imported by build.py to drive the C extension build
sudo dnf install -y gcc make python3-devel python3-setuptools

# Fetch a fresh copy of YouCompleteMe.
rm -rf "${YCM_DIR}"
mkdir -p "${YCM_DIR}"
git clone git@github.com:ycm-core/YouCompleteMe.git "${YCM_DIR}"

# Compile semantic completers.
(
    cd "${YCM_DIR}"
    git submodule update --init --recursive
    python3 install.py --cs-completer --ts-completer --rust-completer --java-completer
)
