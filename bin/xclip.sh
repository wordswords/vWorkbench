#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Pipe stdin to the clipboard via win32yank (Windows) or xclip (Linux).
source "${HOME}/.dotfiles/deploy-common.sh"

cur_os=$(get_os)

RunWin32yank() {
    if [[ "$1" == '-o' ]]; then
        win32yank.exe "$@"
    else
        win32yank.exe -i --crlf "$@"
    fi
}

if [[ "$cur_os" == 'windows' ]] ; then
    RunWin32yank "$@"
fi
if [[ "$cur_os" == 'linux' ]] ; then
    xclip -selection clipboard "$@"
fi

