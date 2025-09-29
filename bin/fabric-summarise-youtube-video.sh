#!/bin/bash

set -e
set -x

youtubeurl=$1

printHelp()
{
 echo "Usage: $0 <Youtube URL>"
 exit 1
}

if [[ -z $youtubeurl ]]
then
 echo "Invalid arguments"
 printHelp
fi

fabric -y $youtubeurl --stream --pattern extract_wisdom
