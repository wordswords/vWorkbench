#!/bin/bash

sudo apt get install joplin-cli || NPM_CONFIG_PREFIX=~/.joplin-bin npm install -g joplin
ln -sf ~/.joplin-bin/bin/joplin ~/bin/joplin
