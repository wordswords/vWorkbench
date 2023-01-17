#!/bin/zsh
set -e

query=$(</dev/stdin)
gg "${query}" >/dev/null 2>/dev/null
echo "${query}"


