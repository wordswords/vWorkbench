#!/usr/bin/env bash
# Install the system prerequisites for the zighouse/zai.vim plugin.
# See the plugin's core Python dependency list before editing:
#   openai, requests, appdirs, chardet, PyYAML, tiktoken

set -euo pipefail

# Chromium is used by Zai's optional web-search/browser tools.
sudo dnf install -y chromium
sudo dnf group install -y "Development Tools"
sudo dnf install -y python3-devel

# Core runtime dependencies (see zai.vim README).
python3 -m pip install --user openai requests appdirs chardet PyYAML tiktoken
