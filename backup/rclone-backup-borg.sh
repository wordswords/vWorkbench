#!/bin/bash
set -e
chown -R david:david /mnt2/borg-backup
./rclone-backup.sh /mnt2/borg-backup borg-backup


