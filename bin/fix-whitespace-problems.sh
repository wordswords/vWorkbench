#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# remove newlines from start of file and end of file
find "$1" -type f -exec sed -i -e '/./,$!d' -e ':a' -e '/^ *$/{$d;N;ba' -e '}' {} \;
# remove trailing whitespace from all files
find "$1" -type f -exec sed -i 's/[ 	]*$//' {} \;
