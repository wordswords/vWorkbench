#!/bin/bash

set -e
find . -maxdepth 1 -print0 | xargs -0 echo | openai_pipe 'what is your best guess at the purpose of the files in this directory, given their naming?'

