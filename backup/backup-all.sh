#!/bin/bash
set -e

sudo ./borg-backup-server-config.sh >/dev/null 2>/dev/null
sudo -u david cd ~/.dotfiles/backup && ./rclone-backup-borg.sh >/dev/null 2>/dev/null
sudo -u david cd ~/.dotfiles/backup && ./rclone-backup-ebooks.sh >/dev/null 2>/dev/null
sudo -u david cd ~/.dotfiles/backup && ./rclone-backup-music.sh >/dev/null 2>/dev/null
sudo -u david cd ~/.dotfiles/backup && ./rclone-backup-TV.sh >/dev/null 2>/dev/null
sudo -u david cd ~/.dotfiles/backup && ./rclone-backup-games.sh >/dev/null 2>/dev/null
sudo -u david cd ~/.dotfiles/backup && ./rclone-backup-video.sh >/dev/null 2>/dev/null

# if it gets this far, it's successful
sudo -u david echo "Last backup success: `date`" > ~/.dotfiles/backup/.last_successful_backup 2>/dev/null
sudo -u david chmod 700 /home/david/.dotfiles/backup/.last_successful_backup >/dev/null 2>/dev/null

# update the git repo
sudo -u david git add ~/.dotfiles/backup/.last_successful_backup && git commit -m 'Updated last successful backup' && git push -f >/dev/null 2>/dev/null


