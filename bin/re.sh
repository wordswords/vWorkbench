#!/bin/bash
set -e
shopt -s lastpipe
read -r input;
echo "inurl:reddit ${input}" | ~/bin/gg.sh
