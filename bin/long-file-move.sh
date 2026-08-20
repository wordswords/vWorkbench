#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Recursively move a directory tree with rsync (removing source files), showing progress.
source_path="$1"
destination_path="$2"

sudo rsync -avzh --remove-source-files --progress "${source_path}" "${destination_path}"
#sudo find "${source_path}" -type d -empty -delete

