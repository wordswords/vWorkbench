#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

filename="$1"

printHelp()
{
 printf '%s\n' "Usage: $0 <file to grep urls from>"
 exit 1
}

if [[ -z "$filename" ]]
then
 printf '%s\n' "Invalid arguments"
 printHelp
fi

grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]' < "${filename}"

