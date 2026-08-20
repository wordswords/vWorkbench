#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Enables automatic package updates on AlmaLinux by installing `dnf-automatic`
# and starting its timer.

sudo dnf install -y dnf-automatic
sudo systemctl enable --now dnf-automatic.timer
