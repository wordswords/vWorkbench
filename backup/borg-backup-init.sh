#!/bin/bash 
set -e
#. ~/.dotfiles/SECRETS/borg-passphrase.sh

sudo apt install borgbackup -y || sudo apt update borgbackup -y
pip3 install msgpack==0.6.1
borg init --encryption=repokey /mnt2/borg-backup

