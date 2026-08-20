#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Iterates over a directory of files, running a number of concurrent processes
# that process the files in parallel. The command, input directory, and
# maximum concurrency are supplied via flags.

print_help()
{
    printf '%s\n' "Usage: $0 -p 3 -i inputDirectory/ -x \"command -to run/\""
    printf '\t-p The maximum number of processes to start concurrently\n'
    printf '\t-i The directory containing the files to run the command on\n'
    printf '\t-x The command to run on the chosen files\n'
    exit 1
}

while getopts "p:x:i:" opt
do
    case "$opt" in
        p ) max_processes="$OPTARG" ;;
        x ) command_to_run="$OPTARG" ;;
        i ) input_dir="$OPTARG"    ;;
        ? ) print_help             ;;
    esac
done

if [[ -z "$max_processes" || -z "$command_to_run" || -z "$input_dir" ]]
then
    printf '%s\n' "Invalid arguments"
    print_help
fi

total="$(ls "$input_dir" | wc -l)"
files="$(ls -Sr "$input_dir")"

for ((k = 1; k <= total; k += max_processes))
do
    for ((i = 0; i <= max_processes; i++))
    do
        if [[ $((i + k)) -gt $total ]]
        then
            wait
            exit 0
        fi

        file="$(sed -n "$((i + k))p" <<< "$files")"
        printf 'Running %s %s/%s\n' "$command_to_run" "$input_dir" "$file"
        $command_to_run "$input_dir/$file" &
    done

    wait
done
