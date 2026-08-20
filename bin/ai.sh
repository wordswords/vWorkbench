#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Feed a single line read from stdin to sgpt (vim/Textomate helper).
shopt -s lastpipe
read -r prompt
sgpt "${prompt}" 2>/dev/null

