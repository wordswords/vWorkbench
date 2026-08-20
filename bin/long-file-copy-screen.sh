#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Run long-file-copy.sh inside a detached screen session (requires root).
source_path="$1"
destination_path="$2"

if [[ $(id -u) -ne 0 ]] ; then
    printf '%s\n' 'You must be root to run this script'
    exit 1
fi

if [[ ! -d "$source_path" ]] ; then
    printf '%s\n' "source_path directory does not exist"
    exit 1
fi
if [[ ! -d "$destination_path" ]] ; then
    printf '%s\n' "destination_path directory does not exist"
    exit 1
fi

/bin/nohup /bin/screen -dm bash -c sudo /home/david/.dotfiles/bin/long-file-copy.sh "$source_path" "$destination_path"

