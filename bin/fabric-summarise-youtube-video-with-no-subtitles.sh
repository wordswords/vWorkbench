#!/bin/bash

set -e
set -x

youtubeurl=$1

printHelp()
{
 echo "Usage: $0 <Youtube URL>"
 exit 1
}

if [[ -z $youtubeurl ]]
then
 echo "Invalid arguments"
 printHelp
fi

yt-dlp $youtubeurl -t mp4 -o ./temp-video-to-transcribe.mp4
fabric --transcribe-file ./temp-video-to-transcribe.mp4 --split-media-file --transcribe-model whisper-1 --pattern extract_wisdom
rm -f ./temp-video-to-transcribe.mp4


