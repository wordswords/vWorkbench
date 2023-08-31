#!/bin/bash

set -e
BOOKPATHROOT=/mnt/ebooks

params="*$**.epub"
bookpath=$(find "${BOOKPATHROOT}" -type f -iname "${params}" | fzf --disabled)
epy "${bookpath}"

