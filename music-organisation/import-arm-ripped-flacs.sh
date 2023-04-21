#!/bin/bash

set -e
set -x

sudo find /home/arm/music -name '*.flac' -type f -exec mv {} /mnt2/incomingmusic/ \;
sudo rm -rf /home/arm/music/*
./music-import.sh

