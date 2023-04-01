#!/bin/bash
set -e
set -x

cd /home/david/.dotfiles/backup/

./borg-backup-server-config.sh
runuser -u david /home/david/.dotfiles/backup/rclone-backup-borg.sh 
runuser -u david /home/david/.dotfiles/backup/rclone-backup-ebooks.sh 
runuser -u david /home/david/.dotfiles/backup/rclone-backup-music.sh 
runuser -u david /home/david/.dotfiles/backup/rclone-backup-TV.sh 
runuser -u david /home/david/.dotfiles/backup/rclone-backup-games.sh 
runuser -u david /home/david/.dotfiles/backup/rclone-backup-video.sh 

# if it gets this far, it's successful

echo Last backup success: $(date) > /home/david/.dotfiles/backup/.last_successful_backup
chown -R david:david /home/david/.dotfiles

# update the git repo
sudo -H -u david -i /home/david/.dotfiles/backup/save-last-backedup.sh



