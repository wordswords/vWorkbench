#!/bin/bash
set -e
shopt -s lastpipe
read -r input;
echo "inurl:stackoverflow ${input}" | ~/bin/gg.sh

