#!/bin/bash

if [ "$(id -u)" -ne 0 ] ; then
    echo 'You must be root to run this script'
    exit 1
fi

set -x
set -e

$SOURCE=$1
$DESTINATION=$2

check if directory exists
if [ ! -d $SOURCE ] ; then
    echo "SOURCE directory does not exist"
    exit 1
fi
if [ ! -d $DESTINATION ] ; then
    echo "DESTINATION directory does not exist"
    exit 1
fi

/bin/nohup /bin/screen -dm bash -c '/home/david/.dotfiles/bin/long-file-move.sh "$SOURCE" "$DESTIONATION'


