#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

filename="$1"

printHelp()
{
 printf '%s\n' "Usage: $0 <file to grep ip addresses from>"
 exit 1
}

if [[ -z "$filename" ]]
then
 printf '%s\n' "Invalid arguments"
 printHelp
fi

grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' < "${filename}" | sort | uniq
