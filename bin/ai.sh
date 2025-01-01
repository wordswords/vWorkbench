#!/bin/bash
set -e
shopt -s lastpipe
read -r input;
echo "${input}" | chatgpt 2>/dev/null


