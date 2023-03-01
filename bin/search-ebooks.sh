#!/bin/bash

set -e
params="*$@*.epub"
epy "`find /mnt/ebooks -type f -iname ${params} | fzf`"

