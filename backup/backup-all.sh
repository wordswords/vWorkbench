#!/bin/bash
if [ $(id -u) -ne 0 ] ; then
    echo 'You must be root to run this script'
    exit 1
fi

# Screen setup
echo "defscrollback 1000000" >> ~/.screenrc
if [ -z "$STY" ]; then exec screen -dm -S backup-all /bin/bash "$0" || /bin/bash; fi

set -e
set -x

cd /home/david/.dotfiles/backup/

./borg-backup-server-config.sh
chown -R david:david /mnt2/borg-backup
runuser -u david /home/david/.dotfiles/backup/rclone-backup-borg.sh

# if it gets this far, it's successful
echo Last backup success: "$(date)" > /home/david/.dotfiles/backup/.last_successful_backup
chown -R david:david /home/david/.dotfiles

# update the git repo
runuser -u david /home/david/.dotfiles/backup/save-last-backedup.sh

hardcopy -h /home/david/.dotfiles/backup/.last_backup_all_run.log



