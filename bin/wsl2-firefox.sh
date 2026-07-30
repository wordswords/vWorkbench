#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# deal with the horribleness that is Firefox under WSL2

sudo dnf remove -y firefox firefox-esr 2>/dev/null || true

sudo dnf install -y firefox

