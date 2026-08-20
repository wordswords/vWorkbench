#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Mount the incoming-music share and move downloaded audio files into it.
source_dir="/mnt/c/Users/conta/Documents/Soulseek Downloads/complete"

sudo mkdir -p /mnt/I
sudo mount -t drvfs '\\hq.local\incomingmusic' /mnt/I
sudo find "${source_dir}" -name '*.flac' -type f -exec mv -v {} /mnt/I/ \;
sudo find "${source_dir}" -name '*.mp3' -type f -exec mv -v {} /mnt/I/ \;
sudo find "${source_dir}" -name '*.wav' -type f -exec mv -v {} /mnt/I/ \;

