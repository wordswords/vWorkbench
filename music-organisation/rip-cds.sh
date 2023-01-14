#!/bin/bash
set -e

while true
do
    ~/.dotfiles/music-organisation/rip-cd.sh
    echo "Insert next CD!" | figlet -f pagga
    echo "* Any key to continue."
    echo "* Control-C to stop."
    read -n 1
done
