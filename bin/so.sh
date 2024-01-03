#!/bin/bash
set -e
shopt -s lastpipe
read -r input;
~/bin/gg.sh "inurl:stackoverflow.com ${input}"

