#!/bin/bash

set -x
set -e

sudo mkdir -p "/mnt/c/Program\ Files/alacritty"
sudo wget https://github.com/alacritty/alacritty/releases/download/v0.13.2/Alacritty-v0.13.2-portable.exe -O "/mnt/c/Program\ Files/alacritty/Alacritty-v0.13.2-portable.exe"
mkdir -p /mnt/c/Users/conta/AppData/Roaming/alacritty
cp ~/.dotfiles/windows-terminal-emulators-config/windows-alacritty.toml /mnt/c/Users/conta/AppData/Roaming/alacritty/alacritty.toml
echo "Now you can run Alacritty by running C:\Program Files\alacritty\Alacritty-v0.13.2-portable.exe from within windows and it will launch WSL"

