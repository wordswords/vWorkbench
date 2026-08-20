#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Select a Joplin notebook, switch to it, then print a note id to paste as a link.
selected_notebook=$(joplin ls / | fzf | awk '{print $1}')
joplin use "${selected_notebook}"
joplin ls -l | fzf | awk '{print $1}'

