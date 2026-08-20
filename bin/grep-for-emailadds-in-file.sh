#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Extract email addresses from a file using grep.
email_file="$1"

printHelp()
{
    printf '%s\n' "Usage: $0 <file to grep emails from>"
    exit 1
}

if [[ -z "$email_file" ]]; then
    printf '%s\n' "Invalid arguments"
    printHelp
fi

grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" < "${email_file}"
