#!/bin/bash 

set -e
find . -maxdepth 1 -type f -print0 | xargs -0 echo | openai_pipe 'For each of these files, provide a description of what is likely to be their contents?'

