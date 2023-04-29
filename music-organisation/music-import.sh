#!/bin/bash
if [ $(id -u) -ne 0 ] ; then
    echo 'You must be root to run this script'
    exit 1
fi


set -e
set -x

# Fix perms
chown -R david:users /mnt2/incomingmusic
chown -R david:users /mnt2/music
chmod -R 775 /mnt2/incomingmusic
chmod -R 775 /mnt2/music

# Import music
runuser -u david /home/david/.dotfiles/music-organisation/beet-import.sh

# Clean incoming directory
rm -rf /mnt2/incomingmusic/*

