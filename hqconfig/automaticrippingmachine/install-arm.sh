#!/bin/bash

set -e
tmpdir=$(mktemp)
sudo rm -rf /home/tmp*arm
sudo apt install wget lsscsi -y
lsscsi -g | grep -q dvd || (echo "No DVD drive found. Exiting" && exit 1)
mkdir ${tmpdir}-arm
chmod -R 777 ${tmpdir}-arm
cd ${tmpdir}-arm
wget https://raw.githubusercontent.com/automatic-ripping-machine/automatic-ripping-machine/v2_devel/scripts/installers/docker-setup.sh
sudo chmod +x ./docker-setup.sh
sudo ./docker-setup.sh
rm -rf ${tmpdir}-arm


