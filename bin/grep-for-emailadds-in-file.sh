#!/bin/bash

set -x
set -e

filename="$1"

printHelp()
{
 echo "Usage: $0 <file to grep emails from>"
 exit 1
}

if [[ -z $filename ]]
then
 echo "Invalid arguments"
 printHelp
fi

cat ${filename} | grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b” file.txt
