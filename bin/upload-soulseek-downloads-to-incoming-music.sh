#!/bin/bash

set -x
set -e

SDIR="/mnt/c/Users/conta/Documents/Soulseek Downloads/complete"

sudo mkdir -p /mnt/I
sudo mount -t drvfs '\\hq.local\incomingmusic' /mnt/I
sudo find "${SDIR}" -name '*.flac' -type f -exec mv -v {} /mnt/I/ \;
sudo find "${SDIR}" -name '*.mp3' -type f -exec mv -v {} /mnt/I/ \;
sudo find "${SDIR}" -name '*.wav' -type f -exec mv -v {} /mnt/I/ \;

