#!/bin/bash

set -e
set -x
sudo apt-get install wine64 -y
sudo ufw allow 5678/udp
sudo ufw allow from 0.0.0.0 to 255.255.255.255
sudo ufw reload

wine ~/.dotfiles/bin/winbox64.exe


