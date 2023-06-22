#!/bin/bash

# Import local Windows Soulseek downloads

SDIR="/mnt/c/Users/conta/Documents/Soulseek Downloads/complete"

sudo mkdir -p /mnt/I
sudo mount -t drvfs '\\hq.local\incomingmusic' /mnt/I
sudo find "${SDIR}" -name '*.flac' -type f -exec mv -v {} /mnt/I/ \;
sudo find "${SDIR}" -name '*.mp3' -type f -exec mv -v {} /mnt/I/ \;
sudo find "${SDIR}" -name '*.wav' -type f -exec mv -v {} /mnt/I/ \;
ssh -t david@hq.local -p608 'sudo chown -R david:users /mnt2/incomingmusic'
ssh -t david@hq.local -p608 '/home/david/.dotfiles/music-organisation/beet-import.sh'
ssh -t david@hq.local -p608 'sudo rm -rf /mnt2/incomingmusic/*'
sudo rm -rf "${SDIR}"/*

