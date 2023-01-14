#!/bin/bash
set -e
mkdir -p /tmp/incomingmusic
sudo chmod -R 777 /tmp/incomingmusic
sudo docker run -ti --rm --device=/dev/cdrom \
    --mount type=bind,source=${HOME}/.config/whipper,target=/home/worker/.config/whipper \
    --mount type=bind,source=/tmp/incomingmusic,target=/tmp/incomingmusic \
    whipperteam/whipper cd rip

find /tmp/incomingmusic -type f -name "*.flac" -exec mv {} /mnt2/incomingmusic \;
rm -rf /tmp/incomingmusic

 ~/.dotfiles/music-organisation/beet-import.sh


