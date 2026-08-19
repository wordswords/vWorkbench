#!/usr/bin/env bash
# Install the managed .zshrc into the home directory.

set -euo pipefail
IFS=$'\n\t'

cp "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
