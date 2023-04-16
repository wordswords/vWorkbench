#!/bin/bash

set -e

if unset "$1"; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Remove all git files from a directory
find "$1" -name ".git*" -exec rm -rf {} \;

