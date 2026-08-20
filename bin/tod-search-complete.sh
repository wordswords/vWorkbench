#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Find and complete the next Todoist task matching the given search terms.
search_terms="$*"
search_filter="search: ${search_terms}"
tod task next -f "${search_filter}"
tod task complete

