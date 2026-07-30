#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# How many commands: a simple script to count how many executable
#   commands are in your current PATH

count=0 ; nonex=0
while IFS=: read -r -d '' directory; do
  if [ -d "$directory" ] ; then
    for command in "$directory"/* ; do
      if [ -x "$command" ] ; then
        count="$(( $count + 1 ))"
      else
        nonex="$(( $nonex + 1 ))"
      fi
    done
  fi
done < <(printf '%s\0' "$PATH")

echo "$count commands, and $nonex entries that weren't executable"

exit 0
