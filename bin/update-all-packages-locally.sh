#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sudo dnf update -y
sudo dnf upgrade -y
