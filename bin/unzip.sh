#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Extracts every `.zip` file in the current directory into its own
# subdirectory, deleting the archive whether extraction succeeds or fails.

shopt -s nullglob

for zipfile in ./*.zip; do
    output_dir="${zipfile%.zip}"
    mkdir -p "$output_dir"
    if unzip -o "$zipfile" -d "$output_dir"; then
        rm -f "$zipfile"
    else
        echo "Warning: Failed to unzip $zipfile (corrupted or invalid). Deleting it."
        rm -f "$zipfile"
    fi
done
