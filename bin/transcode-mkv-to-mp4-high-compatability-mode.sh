#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

inputmkv="$1"

ffmpeg -i "$inputmkv" -c:v libx264 -c:a aac "$inputmkv".mp4

