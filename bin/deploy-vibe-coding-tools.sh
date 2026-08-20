#!/usr/bin/env bash
# Install aider and its browser-automation backend for keyboard-driven coding.

set -euo pipefail

readonly DOTFILES_DIR="${HOME}/.dotfiles"

# Install aider.
curl -LsSf https://aider.chat/install.sh | sh

# Install Playwright for aider's browser automation.
"${DOTFILES_DIR}/bin/install-playwrite-for-aider.sh"

# Expose the aider wrapper so `aider` resolves to the keyboard-driven front-end.
export aider="${DOTFILES_DIR}/bin/aider-wrapper.sh"
