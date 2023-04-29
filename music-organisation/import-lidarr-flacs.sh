#!/bin/bash

set -e
set -x

find /home/lidarr/downloads -name '*.flac' -type f -exec mv {} /mnt2/incomingmusic/ \;
runuser -u david /home/david/.dotfiles/music-organisation/music-import.sh


