#!/bin/bash
# combine_and_make_fortune.sh
# Concatenates all files in current directory into one fortune file.

OUTFILE="combined_fortunes"

# Step 1: Concatenate all files into one, separated by '%'
# This adds a '%' line between each file for fortune formatting
first=true
for file in *; do
    [ -f "$file" ] || continue
    if [ "$file" != "$OUTFILE" ] && [ "$file" != "$OUTFILE.dat" ]; then
        if [ "$first" = true ]; then
            first=false
        else
            echo "%" >> "$OUTFILE"
        fi
        cat "$file" >> "$OUTFILE"
        echo "" >> "$OUTFILE"
    fi
done

# Step 2: Generate the .dat index file for fortune
strfile "$OUTFILE" "$OUTFILE.dat"

echo "Fortune file '$OUTFILE' and index '$OUTFILE.dat' created successfully."


