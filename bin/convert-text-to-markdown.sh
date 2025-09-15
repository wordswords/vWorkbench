#!/bin/bash
textfile="$1"
rm -f "$outputfile" || ''
prompt="Restructure this 'stiched togtheer' file into one coherent markdown file, with proper headings and formatting. The file is a collection of text chunks that need to be organized into a readable coherent format. Also if there are any code blocks, they should be properly formatted in markdown. The file is provided as a context input."
cat "$textfile" | sgpt "$prompt" >> "$outputfile"


