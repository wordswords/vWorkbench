#!/bin/bash

set -e
set -x

videopath=$1

printHelp()
{
 echo "Usage: $0 <Video file path>"
 exit 1
}

if [[ -z "$videopath" ]]
then
 echo "Invalid arguments"
 printHelp
fi

fabric --transcribe-file "$videopath" --split-media-file --transcribe-model whisper-1 --pattern extract_wisdom > "$videopath".fabricsummary.md


