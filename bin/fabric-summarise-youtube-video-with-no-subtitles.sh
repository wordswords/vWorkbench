#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

youtubeurl=$1

printHelp()
{
 printf '%s\n' "Usage: $0 <Youtube URL>"
 exit 1
}

if [[ -z "$youtubeurl" ]]
then
 printf '%s\n' "Invalid arguments"
 printHelp
fi

yt-dlp "$youtubeurl" -t mp4 -o ./temp-video-to-transcribe.mp4
fabric --transcribe-file ./temp-video-to-transcribe.mp4 --split-media-file --transcribe-model whisper-1 --pattern extract_wisdom
rm -f ./temp-video-to-transcribe.mp4

