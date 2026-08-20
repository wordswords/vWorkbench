#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Delete .mkv files in any directory that also contains an .mp4 (defaults to dry-run).
root_directory="${1:-.}"
DRY_RUN="0"   # set to 0 to actually delete

find "$root_directory" -type f \( -iname '*.mp4' -o -iname '*.mkv' \) -printf '%h\0' \
  | sort -zu \
  | while IFS= read -r -d '' dir_path; do
      mp4_count=$(find "$dir_path" -maxdepth 1 -type f -iname '*.mp4' | wc -l)
      mkv_files=$(find "$dir_path" -maxdepth 1 -type f -iname '*.mkv')

      if [[ "$mp4_count" -gt 0 && -n "$mkv_files" ]]; then
        while IFS= read -r mkv_file; do
          if [[ -n "$mkv_file" ]]; then
            if [[ "$DRY_RUN" -eq 1 ]]; then
              echo "Would delete: ${mkv_file}"
            else
              rm -f -- "$mkv_file"
              echo "Deleted: ${mkv_file}"
            fi
          fi
        done <<< "$mkv_files"
      fi
    done
