#!/bin/bash
set -e
shopt -s lastpipe
read -r input;
echo "${input}" | chatgpt-cli -n 2>/dev/null


