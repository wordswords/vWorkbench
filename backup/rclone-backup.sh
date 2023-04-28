#!/bin/bash
set -e
set -x
src=${1}
dst=${2}
rclone sync ${src} gdrive:rclone-backup/${dst} -P --drive-pacer-min-sleep=10ms --drive-pacer-burst=200 --fast-list --exclude nfsmnt

