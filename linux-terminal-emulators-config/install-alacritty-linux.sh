#!/bin/bash

set -x
set -e

sudo apt install alacritty -y
mkdir -p $HOME/.config/alacritty/
cp ~/.dotfiles/linux-terminal-emulators-config/linux-alacritty.yml $HOME/.config/alacritty/alacritty.toml

