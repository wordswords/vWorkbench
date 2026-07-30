#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Enable automatic updates on AlmaLinux
sudo dnf install -y dnf-automatic
sudo systemctl enable --now dnf-automatic.timer
sudo systemctl enable --now dnf-automatic-notifyonly.timer

