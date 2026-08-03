#!/bin/bash

# Install aider
curl -LsSf https://aider.chat/install.sh | sh

# Install playwrite for aider
~/.dotfiles/bin/install-playwrite-for-aider.sh

export aider="~/.dotfiles/bin/aider-wrapper.sh"

