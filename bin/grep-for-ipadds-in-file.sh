#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

filename="$1"

printHelp()
{
 echo "Usage: $0 <file to grep ip addresses from>"
 exit 1
}

if [[ -z $filename ]]
then
 echo "Invalid arguments"
 printHelp
fi

cat "${filename}" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | sort | uniq
