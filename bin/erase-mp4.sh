#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
DRY_RUN="0"   # set to 0 to actually delete

find "$ROOT" -type f \( -iname '*.mp4' -o -iname '*.mkv' \) -printf '%h\0' \
  | sort -zu \
  | while IFS= read -r -d '' dir; do
      mp4_count=$(find "$dir" -maxdepth 1 -type f -iname '*.mp4' | wc -l)
      mkv_files=$(find "$dir" -maxdepth 1 -type f -iname '*.mkv')

      if [[ "$mp4_count" -gt 0 && -n "$mkv_files" ]]; then
        while IFS= read -r mkv; do
          if [[ -n "$mkv" ]]; then
            if [[ "$DRY_RUN" -eq 1 ]]; then
              echo "Would delete: $mkv"
            else
              rm -f -- "$mkv"
              echo "Deleted: $mkv"
            fi
          fi
        done <<< "$mkv_files"
      fi
    done
