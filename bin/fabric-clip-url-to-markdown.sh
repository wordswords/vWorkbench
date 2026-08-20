#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Convert a URL to markdown using fabric.
url="$1"

printHelp()
{
    echo "Usage: $0 <URL to convert to markdown>"
    exit 1
}

if [[ -z "$url" ]]; then
    echo "Invalid arguments"
    printHelp
fi

fabric -u "$url"

