#!/usr/bin/env bash
set -euo pipefail

shopt -s nullglob

for zipfile in ./*.zip; do
  dirname="${zipfile%.zip}"
  mkdir -p "$dirname"
  unzip -o "$zipfile" -d "$dirname"
  rm -f "$zipfile"
done

