#!/bin/bash
set -e
set -x

# Make sure we are running the latest version
pip3 install --upgrade beets

cd /mnt2/incomingmusic
beet import -AmPsq .
beet dup -d

