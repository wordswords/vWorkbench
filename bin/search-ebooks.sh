#!/bin/bash

set -e
BOOKPATHROOT=/mnt/ebooks
PARAMS="*$**.epub"

cd "${BOOKPATHROOT}"
bookpath=$(find . -type f -iname "${PARAMS}" 2>/dev/null | sort -r | fzf --disabled)
epy "${bookpath}"
cd -
