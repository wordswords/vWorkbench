#!/bin/bash

set -x
set -e

filename="$1"
numberoflinesperfile="$2"

printHelp()
{
 echo "Usage: $0 <filename to split> <number of lines per file>"
 exit 1
}

if [[ -z $filename || -z $numberoflinesperfile ]]
then
 echo "Invalid arguments"
 printHelp
fi

TOTAL_LINES=$(wc -l < $filename)
(( LINES_PER_FILE = (TOTAL_LINES + numberoflinesperfile - 1) / numberoflinesperfile ))

split -d -l $numberoflinesperfile $filename ${filename}_part_

echo "Split $filename into $numberoflinesperfile parts."
