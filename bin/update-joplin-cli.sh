#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sudo rm -rf ~/.joplin-bin
sudo dnf install -y fuse-libs
NPM_CONFIG_PREFIX=~/.joplin-bin npm install -g joplin
cd ~/.joplin-bin/lib/node_modules/joplin/
npm install --cpu=x64 --platform=linux sharp
cd ~/.joplin-bin/lib/node_modules/joplin/node_modules/@joplin/tools
npm install --cpu=x64 --platform=linux sharp
ln -sf ~/.joplin-bin/bin/joplin ~/bin/joplin

