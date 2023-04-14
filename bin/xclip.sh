#!/bin/bash

set -e
source ~/.dotfiles/deploy-common.sh

cur_os=$(get_os)

# give an example of an if statement using bash and a string comparison on a variable

if [[ $cur_os == 'windows' ]] ; then
    /mnt/c/Windows/System32/clip.exe "$@"
fi
if [[ $cur_os == 'linux' ]] ; then
    xclip -selection clipboard "$@"
fi


