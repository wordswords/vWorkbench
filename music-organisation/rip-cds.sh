#!/bin/bash
set -e

while true
do
    ~/.dotfiles/music-organisation/rip-cd.sh
    echo "Insert next CD and press a key to continue!" | figlet -f pagga
    echo "Control-C to stop"
    read -n 1
done
