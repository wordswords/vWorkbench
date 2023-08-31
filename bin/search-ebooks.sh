#!/bin/bash

set -e
params="*$**.epub"
bookpath=$(find /mnt/ebooks -type f -iname "${params}" | fzf --disabled)
epy "${bookpath}"

