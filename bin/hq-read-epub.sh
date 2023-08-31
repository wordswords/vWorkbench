#!/bin/bash

set -e

QUERY="$*"
ssh -p608 david@hq.local -t "/bin/bash /home/david/.dotfiles/bin/search-ebooks.sh ${QUERY}"

