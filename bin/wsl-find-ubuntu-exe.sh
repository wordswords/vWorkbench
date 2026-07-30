#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sudo find /mnt/c -name 'ubuntu*.exe' -type f 2>/dev/null
echo "Now open an admin console and run this file to change settings"

