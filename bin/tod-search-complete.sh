#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

allargs="$@"
query="search: ${allargs}"
tod task next -f "${query}"
tod task complete

