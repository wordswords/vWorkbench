#!/bin/bash

set -x
set -e

sudo snap install --classic alacritty || sudo snap update --classic alacritty
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 50
mkdir -p $HOME/.config/alacritty/
cp ~/.dotfiles/linux-terminal-emulators-config/linux-alacritty.toml $HOME/.config/alacritty/alacritty.toml
~/.dotfiles/linux-terminal-emulators-config/install-nerdfont-linux.sh

echo "Now start alacritty from the search applications menu, and then pin it to the dock"


