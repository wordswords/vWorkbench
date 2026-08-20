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

# Fetch a fresh copy of YouCompleteMe.
rm -rf "${YCM_DIR}"
mkdir -p "${YCM_DIR}"
git clone git@github.com:ycm-core/YouCompleteMe.git "${YCM_DIR}"

# Compile semantic completers.
(
    cd "${YCM_DIR}"
    git submodule update --init --recursive
    python3.12 install.py --cs-completer --ts-completer --rust-completer --java-completer
)
