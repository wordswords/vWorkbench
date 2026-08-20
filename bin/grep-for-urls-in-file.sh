#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Extract URLs from a file using grep.
input_file="$1"

printHelp()
{
    printf '%s\n' "Usage: $0 <file to grep urls from>"
    exit 1
}

if [[ -z "$input_file" ]]; then
    printf '%s\n' "Invalid arguments"
    printHelp
fi

grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]' < "${input_file}"

