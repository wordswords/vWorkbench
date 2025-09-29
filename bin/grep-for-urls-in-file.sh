#!/bin/bash

set -x
set -e

filename="$1"

printHelp()
{
 echo "Usage: $0 <file to grep urls from>"
 exit 1
}

if [[ -z $filename ]]
then
 echo "Invalid arguments"
 printHelp
fi

cat ${filename} | grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]'

