#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

shopt -s lastpipe
read -r input;
sgpt "${input}" 2>/dev/null

