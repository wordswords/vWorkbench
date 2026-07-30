#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SOURCE="$1"
DESTINATION="$2"

sudo rsync -avzh --progress "${SOURCE}" "${DESTINATION}"

