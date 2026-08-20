#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Install wine, open the winbox firewall port, and launch winbox64.exe.
sudo dnf install -y wine
sudo firewall-cmd --add-port=5678/udp --permanent
sudo firewall-cmd --add-source=0.0.0.0/0 --permanent
sudo firewall-cmd --reload

wine "${HOME}/.dotfiles/bin/winbox64.exe"
