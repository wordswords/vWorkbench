#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Counts how many executable commands are in the current PATH, and how many
# entries are not executable.

executable_count=0
non_executable_count=0
while IFS=: read -r -d '' directory; do
    if [[ -d "$directory" ]]; then
        for command in "$directory"/*; do
            if [[ -x "$command" ]]; then
                ((executable_count++))
            else
                ((non_executable_count++))
            fi
        done
    fi
done < <(printf '%s\0' "$PATH")

echo "$executable_count commands, and $non_executable_count entries that weren't executable"

exit 0
