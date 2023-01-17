#!/bin/zsh
set -e

query=$(</dev/stdin)
so "${query}" >/dev/null 2>/dev/null
echo "${query}"


