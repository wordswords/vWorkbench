#!/bin/bash

set -e
set -x

mkdir -p ~/.fonts
cp -r ~/.dotfiles/.fonts/* ~/.fonts
sudo fc-cache -fv

