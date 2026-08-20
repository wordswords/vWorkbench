#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Remotely connects to my home server and allows me to read an epub in the terminal.

if [ $# -eq 0 ]; then
    >&2 echo "Usage: $0 <search terms>"
    exit 1
fi

search_terms="$*"
ssh -p608 david@hq.local -t "/bin/bash /home/david/.dotfiles/bin/search-ebooks.sh ${search_terms}"

