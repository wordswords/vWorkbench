#!/bin/bash

set -e
set -x

sudo find /home/lidarr/downloads -name '*.flac' -type f -exec mv {} /mnt2/incomingmusic/ \;
./music-import.sh

