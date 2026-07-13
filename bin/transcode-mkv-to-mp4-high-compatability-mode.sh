#!/bin/bash

set -x
set -e

inputmkv="$1"

ffmpeg -i "$inputmkv" -c:v libx264 -c:a aac "$inputmkv".mp4


