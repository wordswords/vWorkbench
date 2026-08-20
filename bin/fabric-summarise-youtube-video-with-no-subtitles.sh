#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Download a YouTube video, transcribe it (no subtitles) and extract wisdom via fabric.
youtube_url="$1"

printHelp()
{
    printf '%s\n' "Usage: $0 <YouTube URL>"
    exit 1
}

if [[ -z "$youtube_url" ]]; then
    printf '%s\n' "Invalid arguments"
    printHelp
fi

yt-dlp "$youtube_url" -t mp4 -o ./temp-video-to-transcribe.mp4
fabric --transcribe-file ./temp-video-to-transcribe.mp4 --split-media-file --transcribe-model whisper-1 --pattern extract_wisdom
rm -f ./temp-video-to-transcribe.mp4

