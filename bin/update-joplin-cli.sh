#!/bin/bash

sudo rm -rf ~/.joplin-bin
sudo apt install joplin-cli || NPM_CONFIG_PREFIX=~/.joplin-bin npm install --force -g joplin
ln -sf ~/.joplin-bin/bin/joplin ~/bin/joplin
