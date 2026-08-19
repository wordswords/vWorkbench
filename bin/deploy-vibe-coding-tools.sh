#!/usr/bin/env bash
# Install aider and its browser-automation backend for keyboard-driven coding.

set -euo pipefail

# Install aider.
curl -LsSf https://aider.chat/install.sh | sh

# Install Playwright for aider's browser automation.
"$HOME/.dotfiles/bin/install-playwrite-for-aider.sh"

export aider="$HOME/.dotfiles/bin/aider-wrapper.sh"
