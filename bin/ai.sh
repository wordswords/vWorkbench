#!/bin/bash
set -e
shopt -s lastpipe
read -r input;
echo "${input}" | chatgpt-cli -m gpt-4 -k "${OPEN_API_KEY}" -n 2>/dev/null


