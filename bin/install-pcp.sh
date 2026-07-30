#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

#sudo apt install pcp-system-tools
sudo apt install pcp
sudo apt install pcp-conf
sudo apt install pcp-doc
sudo apt install pcp-gui
sudo systemctl enable pmcd.service
sudo systemctl start pmcd.service

