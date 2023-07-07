#!/bin/bash
set -e
shopt -s lastpipe
read -r input;
"/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe google inurl:reddit.com" "${input}"

