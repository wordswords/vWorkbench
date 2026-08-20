#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Removes all Git metadata (`.git*` files and directories) from the directory
# supplied as the first argument.

if [[ $# -eq 0 ]]; then
    >&2 echo "Usage: $0 <directory>"
    exit 1
fi

target_dir="$1"

find "$target_dir" -name ".git*" -exec rm -rf {} \;
