#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Concatenates all files in the current directory into a single fortune file,
# then generates the corresponding `.dat` index used by the `fortune` command.

output_file="combined_fortunes"

# Step 1: Concatenate all files into one, separated by '%'
# This adds a '%' line between each file for fortune formatting
is_first_file=true
for file in *; do
    [[ -f "$file" ]] || continue
    if [[ "$file" != "$output_file" ]] && [[ "$file" != "$output_file.dat" ]]; then
        if [[ "$is_first_file" == true ]]; then
            is_first_file=false
        else
            printf '%%\n' >> "$output_file"
        fi
        cat "$file" >> "$output_file"
        printf '\n' >> "$output_file"
    fi
done

# Step 2: Generate the .dat index file for fortune
strfile "$output_file" "$output_file.dat"

echo "Fortune file '$output_file' and index '$output_file.dat' created successfully."

