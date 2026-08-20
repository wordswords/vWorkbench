#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Recursively copy a directory tree with rsync, showing progress.
source_path="$1"
destination_path="$2"

sudo rsync -avzh --progress "${source_path}" "${destination_path}"

