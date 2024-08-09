#!/bin/bash

sudo rm -rf ~/.joplin-bin
sudo apt install libfuse2 -y
NPM_CONFIG_PREFIX=~/.joplin-bin npm install -g joplin
ln -sf ~/.joplin-bin/bin/joplin ~/bin/joplin

