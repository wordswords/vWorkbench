#!/bin/bash
if [ $(id -u) -ne 0 ] ; then
    echo 'You must be root to run this script'
    exit 1
fi


set -e
set -x

# Make sure we are running the latest version
pip3 install --upgrade beets

# Fix perms

USER=`whoami`
chown -R $USER:users /mnt2/incomingmusic
chown -R $USER:users /mnt2/music
chmod -R 775 /mnt2/incomingmusic
chmod -R 775 /mnt2/music

# Import music
cd /mnt2/incomingmusic
beet import -AmPsq .
beet dup -d

# Clean incoming directory
rm -rf /mnt2/incomingmusic/*

