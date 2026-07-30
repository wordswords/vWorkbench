#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

shopt -s lastpipe
read -r input;
~/bin/gg.sh "inurl:reddit.com ${input}"
