#!/usr/bin/env bash
# Install YouCompleteMe prerequisites and compile the plugin.
# Assumes node is already installed.

set -euo pipefail
IFS=$'\n\t'

readonly YCM_DIR="$HOME/.vim/bundle/YouCompleteMe"

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
