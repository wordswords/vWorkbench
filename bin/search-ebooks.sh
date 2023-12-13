#!/bin/bash

set -e
if [ $# -eq 0 ]; then
    >&2 echo "Usage: $0 <epub library search terms>"
    exit 1
fi

BOOKPATHROOT=/mnt/ebooks
PARAMS="*$**.epub"

EPY_PATH="/home/${USER}/.local/bin/epy"
cd "${BOOKPATHROOT}"
bookpath=$(find . -type f -iname "${PARAMS}" 2>/dev/null | sort -r | fzf --disabled)
"${EPY_PATH}" "${bookpath}"
cd -
