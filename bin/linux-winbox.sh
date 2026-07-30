#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sudo dnf install -y wine
sudo ufw allow 5678/udp
sudo ufw allow from 0.0.0.0 to 255.255.255.255
sudo ufw reload

wine ~/.dotfiles/bin/winbox64.exe

