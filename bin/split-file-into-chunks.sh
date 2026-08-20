#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Split a file into numbered chunks of a given size.
input_file="$1"
lines_per_file="$2"

printHelp()
{
    echo "Usage: $0 <filename to split> <number of lines per file>"
    exit 1
}

if [[ -z "$input_file" || -z "$lines_per_file" ]]; then
    echo "Invalid arguments"
    printHelp
fi

split -d -l "$lines_per_file" "$input_file" "${input_file}_part_"

echo "Split ${input_file} into ${lines_per_file}-line chunks."
