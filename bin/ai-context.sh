#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Split a text file into 1000-line chunks and feed each one to sgpt using a prompt.
# Usage: $0 <user_prompt> <input_file>
user_prompt="$1"
input_file="$2"
output_file="notes-on-${input_file}.md"

rm -f "$output_file" || true
echo "Input file = ${input_file}"

rm -f chunk_*
split -l 1000 -d "$input_file" chunk_

for chunk_file in chunk_*; do
    echo "Processing ${chunk_file}"
    line_count=$(wc -l < "$chunk_file")
    echo "${chunk_file} has ${line_count} lines"

    if [ "$line_count" -lt 1000 ]; then
        chunk_prompt="I am in the process of feeding you the last chunk of a text file, which is under 1000 lines. Please process the prompt on this chunk. The prompt is: ${user_prompt}, the current chunk is provided as a context input"
        cat "$chunk_file" | sgpt "$chunk_prompt" >> "$output_file"
        continue
    fi

    cat "$chunk_file" | sgpt "$user_prompt" >> "$output_file"
done

