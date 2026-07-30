#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Install ADOM - Ancient Domains of Mystery - my 'desert island' game

sudo apt install libncurses5 -y
wget https://www.adom.de/home/download/current/adom_linux_ubuntu_64_3.3.3.tar.gz
tar xzf adom* ./adom
cp ./adom*/adom ~/bin
rm -rf ./adom*

