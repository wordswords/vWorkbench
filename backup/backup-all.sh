#!/bin/bash

set -x
set -e

sudo ./borg-backup-server-config.sh
sudo -u david cd ~/.dotfiles/backup && ./rclone-backup-borg.sh
sudo -u david cd ~/.dotfiles/backup && ./rclone-backup-ebooks.sh
sudo -u david cd ~/.dotfiles/backup && ./rclone-backup-music.sh
sudo -u david cd ~/.dotfiles/backup && ./rclone-backup-TV.sh
sudo -u david cd ~/.dotfiles/backup && ./rclone-backup-games.sh
sudo -u david cd ~/.dotfiles/backup && ./rclone-backup-video.sh

# if it gets this far, it's successful
echo "OK" > /home/david/.dotfiles/backup/.last_successful_backup
chmod 700 /home/david/.dotfiles/backup/.last_successful_backup
chown david:david ~/.dotfiles/backup/.last_successful_backup

# update the git repo
sudo -u david git add ~/.dotfiles/backup/.last_successful_backup && git commit -m 'updated last successful backup' && git push -f

