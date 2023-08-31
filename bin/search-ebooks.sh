#!/bin/bash

set -e
BOOKPATHROOT=/mnt/ebooks
PARAMS="*$**.epub"
EPY_PATH="/home/david/.local/bin/epy"

cd "${BOOKPATHROOT}"
bookpath=$(find . -type f -iname "${PARAMS}" 2>/dev/null | sort -r | fzf --disabled)
"${EPY_PATH}" "${bookpath}"
cd -
