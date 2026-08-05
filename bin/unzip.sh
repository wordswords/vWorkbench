#!/usr/bin/env bash
set -euo pipefail

shopt -s nullglob

for zipfile in ./*.zip; do
  dirname="${zipfile%.zip}"
  mkdir -p "$dirname"
  if unzip -o "$zipfile" -d "$dirname"; then
    rm -f "$zipfile"
  else
    echo "Warning: Failed to unzip $zipfile (corrupted or invalid). Deleting it."
    rm -f "$zipfile"
  fi
done
