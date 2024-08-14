#!/bin/bash

set -e
set -x
#https://wiki.debian.org/UnattendedUpgrades
sudo apt-get install unattended-upgrades apt-listchanges -y
sudo echo unattended-upgrades unattended-upgrades/enable_auto_updates boolean true | sudo debconf-set-selections
sudo dpkg-reconfigure -f noninteractive unattended-upgrades
sudo cp ~/.dotfiles/50unattended-upgrades /etc/apt/apt.conf.d/
sudo cp ~/.dotfiles/20auto-upgrades /etc/apt/apt.conf.d/

