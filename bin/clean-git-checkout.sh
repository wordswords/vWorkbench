#!/bin/bash

set -e
if [ $# -eq 0 ]; then
    >&2 echo "Usage: $0 <directory>"
    exit 1
fi

# Remove all git files from a directory
find "$1" -name ".git*" -exec rm -rf {} \;

