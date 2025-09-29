#!/bin/bash

set -e
shopt -s lastpipe
# Read multi-line input from stdin
read -r input;
# Arbitrary command to run on each line of input
command="$1"
set -x

printHelp()
{
 echo "Usage: echo "Example data" | $0 <${command}>"
 exit 1
}

if [[ -z $input || -z $command ]]
then
 echo "Invalid arguments"
 printHelp
fi

# Check if GNU Parallel is installed
if ! command -v parallel &> /dev/null; then
    echo "GNU Parallel is not installed. Please install it and try again."
    exit 1
fi

# Number of workers
workers=4

# Export command for parallel execution
export command

# Use GNU Parallel to run the command on each line with the specified number of workers
echo "$input" | parallel -j "$workers" "$command" {}
