#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Reads multi-line input from stdin and runs a command on each line in
# parallel using GNU Parallel. The command is supplied as the first argument.

shopt -s lastpipe
read -r input
command_to_run="$1"

print_help()
{
    printf '%s\n' 'Usage: echo "Example data" | '"$0"' <command>'
    exit 1
}

if [[ -z "$input" || -z "$command_to_run" ]]
then
    printf '%s\n' "Invalid arguments"
    print_help
fi

# Check if GNU Parallel is installed
if ! command -v parallel &> /dev/null; then
    printf '%s\n' "GNU Parallel is not installed. Please install it and try again."
    exit 1
fi

# Number of workers
max_processes=4

# Export command for parallel execution
export command_to_run

# Use GNU Parallel to run the command on each line with the specified number of workers
printf '%s\n' "$input" | parallel -j "$max_processes" "$command_to_run" {}
