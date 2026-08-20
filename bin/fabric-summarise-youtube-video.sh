#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Summarise a YouTube video by streaming its transcript through fabric agents.
youtube_url="$1"

printHelp()
{
    echo "Usage: $0 <YouTube URL>"
    exit 1
}

if [[ -z "$youtube_url" ]]; then
    echo "Invalid arguments"
    printHelp
fi

fabric -y "${youtube_url}" --stream --pattern extract_wisdom_agents

