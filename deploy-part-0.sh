#!/bin/bash
# vim: spell set nowrap

set -e
source ./deploy-common.sh

report_heading 'Deploy Prerequisites: Part 0'

report_progress 'We will now attempt to install the preqs under Ubuntu-compatible systems.'

# vim9
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update && sudo apt upgrade
sudo apt upgrade vim
# speedtest-cli
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt-get install speedtest
# git
sudo apt install git
# Python 3 used for vim plugins
sudo apt install python3
sudo apt install python3-pip
# Java open jdk, used for LanguageTool checker
sudo apt install default-jdk
# zsh the best shell (so far)
sudo apt install zsh
# Used for encrypted .secure dir
sudo apt install ecryptfs-utils
# Ctags used for fugative 
sudo apt install exuberant-ctags
# net-tools used for?
sudo apt install net-tools
# Install fortune cookie for shell login
sudo apt install fortune-mod
# Ripgrep used for :CocSearch
sudo apt install ripgrep
# tree is very useful for showing directory structures'
sudo apt install tree
report_done

report_progress 'We will now attempt to enable automated unattended-upgrades'
sudo apt install unattended-upgrades
sudo dpkg-reconfigure unattended-upgrades
report_done




