#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SOURCE=$1
DESTINATION=$2

if [[ $(id -u) -ne 0 ]] ; then
    printf '%s\n' 'You must be root to run this script'
    exit 1
fi

if [[ ! -d "$SOURCE" ]] ; then
    printf '%s\n' "SOURCE directory does not exist"
    exit 1
fi
if [[ ! -d "$DESTINATION" ]] ; then
    printf '%s\n' "DESTINATION directory does not exist"
    exit 1
fi

/bin/nohup /bin/screen -dm bash -c sudo /home/david/.dotfiles/bin/long-file-copy.sh "$SOURCE" "$DESTINATION"

