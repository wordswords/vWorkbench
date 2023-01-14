#!/bin/bash

set -e

cd /mnt2/incomingmusic
beet import -AmPsq .
beet dup -d
sudo rm -rf /mnt2/incomingmusic/*
