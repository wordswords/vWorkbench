#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Install Firefox on AlmaLinux via RPM Fusion
sudo dnf install -y epel-release
sudo dnf install -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm
sudo dnf install -y firefox

