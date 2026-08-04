#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Compile and install python 3.12
~/.dotfiles/bin/compile-python-almalinux.sh
export alias python3="python3.12"

# Assumes node is already installed - Installs all other prereqs for YCM
sudo dnf install -y mono-complete golang
sudo dnf install -y java-latest-openjdk java-latest-openjdk-devel

# Install YCM
sudo rm -rf ~/.vim/bundle/YouCompleteMe || true
mkdir -p ~/.vim/bundle/YouCompleteMe
chmod -R 700 ~/.vim/bundle/YouCompleteMe/ || true
cd ~/.vim/bundle/YouCompleteMe/
git clone git@github.com:ycm-core/YouCompleteMe.git ./
cd ~/.vim/bundle/YouCompleteMe/
git submodule update --init --recursive
python3.12 install.py --cs-completer --ts-completer --rust-completer --java-completer
