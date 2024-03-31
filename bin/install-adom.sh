#!/bin/bash

set -x
set -e

# Install ADOM - Ancient Domains of Mystery - my 'desert island' game

sudo apt install libncurses5 -y
wget https://www.adom.de/home/download/current/adom_linux_ubuntu_64_3.3.3.tar.gz
tar zxf adom_linux*
cp ./adom/adom ~/bin
rm -rf ./adom*

