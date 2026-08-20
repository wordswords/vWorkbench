#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Transcribe an existing video file (with no subtitles) and extract wisdom via fabric.
video_file="$1"

printHelp()
{
    echo "Usage: $0 <Video file path>"
    exit 1
}

if [[ -z "$video_file" ]]; then
    echo "Invalid arguments"
    printHelp
fi

fabric --transcribe-file "$video_file" --split-media-file --transcribe-model whisper-1 --pattern extract_wisdom > "${video_file}.fabricsummary.md"

