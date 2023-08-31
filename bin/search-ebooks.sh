#!/bin/bash

set -e
BOOKPATHROOT=/mnt/ebooks

params="*$**.epub"
bookpath=$(find "${BOOKPATHROOT}" -type f -iname "${params}" 2>/dev/null | fzf --disabled)
epy "${bookpath}"

