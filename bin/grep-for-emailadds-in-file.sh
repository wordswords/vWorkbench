#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

filename="$1"

printHelp()
{
 printf '%s\n' "Usage: $0 <file to grep emails from>"
 exit 1
}

if [[ -z "$filename" ]]
then
 printf '%s\n' "Invalid arguments"
 printHelp
fi

grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" < "${filename}"
