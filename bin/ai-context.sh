#!/bin/bash
userprompt="$1"
pdf="$2"
outputfile="notes-on-$pdf.md"
rm -f "$outputfile" || ''
echo "pdf = $pdf"
promptfile=$(mktemp)
echo "$prompt" > "$promptfile"
rm chunk_*
# Split the input file into 1000-line chunks
split -l 1000 -d "$pdf" chunk_
#
# Loop through each chunk file
for file in $(ls -h chunk_*)
do
    echo "Processing $file"
    # Example processing: count lines in the chunk
    line_count=$(wc -l < "$file")
    echo "$file has $line_count lines"

    if [ "$line_count" -lt 1000 ]; then
        prompt="I am in the process of feeding you the last chunk of a text file, which is under 1000 lines. Please process the prompt on this chunk. The prompt is: $userprompt, the current chunk is provided as a context input"
        cat "$file" | sgpt "$prompt" >> "$outputfile"
        continue
    else
        # Add your processing commands here
        # For example, you could run some command on $fileA
        cat "$file" | sgpt "$prompt" >> "$outputfile"
    fi
done


