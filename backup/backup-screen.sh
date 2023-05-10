#!/bin/bash


if [ "$(id -u)" -ne 0 ] ; then
    echo 'You must be root to run this script'
    exit 1
fi

set -x
set -e

screen -dm bash -c '/home/david/.dotfiles/backup/backup-all.sh' 

