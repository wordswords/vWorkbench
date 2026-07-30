#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# update wsl2 to latest version

find /mnt/c/Program\ Files/WindowsApps/ -name 'wsl.exe' -type f -exec {} --update \;

