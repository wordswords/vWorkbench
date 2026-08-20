#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Extract IPv4 addresses from a file using grep.
input_file="$1"

printHelp()
{
    printf '%s\n' "Usage: $0 <file to grep ip addresses from>"
    exit 1
}

if [[ -z "$input_file" ]]; then
    printf '%s\n' "Invalid arguments"
    printHelp
fi

grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' < "${input_file}" | sort | uniq
