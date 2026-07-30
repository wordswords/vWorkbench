#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SOURCE="$1"
DESTINATION="$2"

sudo rsync -avzh --remove-source-files --progress "${SOURCE}" "${DESTINATION}"
sudo find "${SOURCE}" -type d -empty -delete

