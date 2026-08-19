#!/usr/bin/env bash

sudo dnf install git make perl
git clone https://gitlab.com/surfraw/Surfraw.git /tmp/surfraw
cd /tmp/surfraw
./configure --prefix=/usr/local
make
sudo make install
cd -

