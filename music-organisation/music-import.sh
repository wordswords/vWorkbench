#!/bin/bash

set -e
set -x

# Make sure we are running the latest version
sudo pip3 install --upgrade beets

# Fix perms

USER=`whoami`
sudo chown -R $USER:users /mnt2/incomingmusic
sudo chown -R $USER:users /mnt2/music
sudo chmod -R 775 /mnt2/incomingmusic
sudo chmod -R 775 /mnt2/music

# Import music
cd /mnt2/incomingmusic
beet import -AmPsq .
beet dup -d

# Clean incoming directory
sudo rm -rf /mnt2/incomingmusic/*

# Backup music
cd ~/.dotfiles/backup/ && ~/.dotfiles/backup/rclone-backup-music.sh

