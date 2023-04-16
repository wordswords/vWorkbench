#!/bin/bash

set -e
set -x

# update wsl2 to latest version

find /mnt/c/Program\ Files/WindowsApps/ -name 'wsl.exe' -type f -exec {} --update \;

