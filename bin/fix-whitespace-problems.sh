#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Removes leading/trailing blank lines and trailing whitespace from every file
# under the given directory (passed as the first argument).

target_dir="$1"

# Remove newlines from start of file and end of file
find "$target_dir" -type f -exec sed -i -e '/./,$!d' -e ':a' -e '/^ *$/{$d;N;ba' -e '}' {} \;
# Remove trailing whitespace from all files
find "$target_dir" -type f -exec sed -i 's/[ \t]*$//' {} \;
