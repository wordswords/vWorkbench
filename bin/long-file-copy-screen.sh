#!/bin/bash

SOURCE=$1
DESTINATION=$2

if [ "$(id -u)" -ne 0 ] ; then
    echo 'You must be root to run this script'
    exit 1
fi

set -x
set -e


if [ ! -d "$SOURCE" ] ; then
    echo "SOURCE directory does not exist"
    exit 1
fi
if [ ! -d "$DESTINATION" ] ; then
    echo "DESTINATION directory does not exist"
    exit 1
fi

/bin/nohup /bin/screen -dm bash -c sudo /home/david/.dotfiles/bin/long-file-copy.sh "$SOURCE" "$DESTINATION"


