#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sudo dnf install -y pcp pcp-conf pcp-doc pcp-gui
sudo systemctl enable pmcd.service
sudo systemctl start pmcd.service
