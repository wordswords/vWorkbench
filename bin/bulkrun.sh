#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# bulkrun--Iterates over a directory of files, running a number of
#   concurrent processes that will process the files in parallel

printHelp()
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
   p ) procs="$OPTARG"    ;;
   x ) command="$OPTARG"  ;;
   i ) inputdir="$OPTARG" ;;
   ? ) printHelp          ;;
 esac
done

if [[ -z $procs || -z $command || -z $inputdir ]]
then
 printf '%s\n' "Invalid arguments"
 printHelp
fi

total=$(ls "$inputdir" | wc -l)
files="$(ls -Sr "$inputdir")"

for ((k=1; k<=total; k+=procs))
do
 for ((i=0; i<=procs; i++))
 do
   if [[ $((i+k)) -gt $total ]]
   then
     wait
     exit 0
   fi

   file=$(sed -n "$((i+k))p" <<< "$files")
   printf 'Running %s %s/%s\n' "$command" "$inputdir" "$file"
   $command "$inputdir/$file" &
 done

 wait
done
