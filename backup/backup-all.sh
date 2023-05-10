#!/bin/bash

if [ "$(id -u)" -ne 0 ] ; then
    echo 'You must be root to run this script'
    exit 1
fi

logfile=/home/david/.dotfiles/backup/.backup_log
exec > >(tee "$logfile") 2>&1

set -x
set -e

error() {
  local parent_lineno="$1"
  local message="$2"
  local code="${3:-1}"
  if [[ -n "$message" ]] ; then
    echo "Error on or near line ${parent_lineno}: ${message}; exiting with status ${code}" | tee >> /home/david/.dotfiles/backup/.backup_error
  else
    echo "Error on or near line ${parent_lineno}; exiting with status ${code}" | tee >> /home/david/.dotfiles/backup/.backup_error
  fi
  read -p "** Press any key to exit **"
  exit "${code}"
}
trap 'error ${LINENO}' ERR

backupall() {
	# Screen setup
	echo "defscrollback 1000000" > ~/.screenrc

	cd /home/david/.dotfiles/backup/
	./borg-backup-server-config.sh
	chown -R david:david /mnt2/borg-backup
	runuser -u david /home/david/.dotfiles/backup/rclone-backup-borg.sh

	# if it gets this far, it's successful
	echo Last backup success: "$(date)" > /home/david/.dotfiles/backup/.last_successful_backup
	chown -R david:david /home/david/.dotfiles

	# update the git repo
	runuser -u david /home/david/.dotfiles/backup/save-last-backedup.sh
}
trap backupall 0

