#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

python3 -m pip install -U --pre "yt-dlp[default]" --break-system-packages

