#!/bin/bash

# Remotely connects to my home server and allows me to read an epub in the terminal.

set -e

if [ $# -eq 0 ]; then
    >&2 echo "Usage: $0 <search terms>"
    exit 1
fi

QUERY="$*"
ssh -p608 david@hq.local -t "/bin/bash /home/david/.dotfiles/bin/search-ebooks.sh ${QUERY}"

