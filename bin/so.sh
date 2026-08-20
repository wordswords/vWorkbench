#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Reads a query from stdin and opens a Google search restricted to
# stackoverflow.com.

shopt -s lastpipe
read -r query
~/bin/gg.sh "inurl:stackoverflow.com ${query}"
