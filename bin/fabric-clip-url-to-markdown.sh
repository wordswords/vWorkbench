#!/bin/bash

set -e
set -x

websitetomd=$1

printHelp()
{
 echo "Usage: $0 <URL to convert to markdown>"
 exit 1
}

if [[ -z $websitetomd ]]
then
 echo "Invalid arguments"
 printHelp
fi

fabric -u $websitetomd

