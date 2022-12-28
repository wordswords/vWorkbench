#!/bin/bash
set -e
sudo chown -R david:david /mnt2/borg-backup
rclone copy /mnt2/borg-backup gdrive:rclone-backup/borg-backup -P --fast-list &


