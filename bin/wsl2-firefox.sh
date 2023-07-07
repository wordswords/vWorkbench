#!/bin/bash

set -e
set -x

# deal with the horribleness that is Firefox under WSL2

sudo snap remove firefox || true
sudo snap remove firefox-esr || true
sudo add-apt-repository ppa:mozillateam/ppa || true

# Insert these lines, then save and exit
echo '''
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 501
''' > /tmp/mozillateamppa
sudo mv /tmp/mozillateamppa /etc/apt/preferences.d/mozillateamppa

sudo apt update
sudo apt install firefox-esr # or firefox-esr

# hack to make firefox work with other scripts
sudo ln -s /bin/firefox /snap/bin/firefox-esr ||  true

