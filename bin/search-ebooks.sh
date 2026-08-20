#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Search the epub library on /mnt/ebooks and open a match in the epy terminal reader.

if [[ $# -eq 0 ]]; then
    printf '%s\n' "Usage: $0 <epub library search terms>" >&2
    exit 1
fi

EBOOKS_DIRECTORY="/mnt/ebooks"
book_name_glob="*${*}*.epub"
epy_binary="${HOME}/.local/bin/epy"

cd "${EBOOKS_DIRECTORY}"
selected_epub=$(find . -type f -iname "${book_name_glob}" 2>/dev/null | sort -r | fzf --disabled)
"${epy_binary}" "${selected_epub}"
cd -
