#!/bin/bash 

set -e

cd /mnt2/incomingmusic
beet import -AmPsq .
sudo rm -rf /mnt2/incomingmusic/*

