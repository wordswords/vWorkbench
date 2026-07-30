#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

notebook=$(joplin ls / | fzf | awk '{print $1}')
joplin use "${notebook}"
joplin ls -l | fzf | awk '{print $1}'

