#!/bin/bash
if [ $(id -u) -ne 0 ] ; then
    echo 'You must be root to run this script'
    exit 1
fi

#if [ -z "$STY" ]; then exec screen -dm -S backup-all /bin/bash "$0"; fi

set -e
set -x

cd /home/david/.dotfiles/backup/

#./borg-backup-server-config.sh
chown -R david:david /mnt2/borg-backup
runuser -u david /home/david/.dotfiles/backup/rclone-backup-borg.sh

# currently disabled individual rclone backups

#runuser -u david /home/david/.dotfiles/backup/rclone-backup-ebooks.sh
#runuser -u david /home/david/.dotfiles/backup/rclone-backup-music.sh
#runuser -u david /home/david/.dotfiles/backup/rclone-backup-TV.sh
#runuser -u david /home/david/.dotfiles/backup/rclone-backup-games.sh
#runuser -u david /home/david/.dotfiles/backup/rclone-backup-video.sh

# if it gets this far, it's successful
echo Last backup success: "$(date)" > /home/david/.dotfiles/backup/.last_successful_backup
chown -R david:david /home/david/.dotfiles

# update the git repo
runuser -u david /home/david/.dotfiles/backup/save-last-backedup.sh



