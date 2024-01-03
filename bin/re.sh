#!/bin/bash
set -e
shopt -s lastpipe
read -r input;
~/bin/gg.sh "inurl:reddit.com ${input}"
