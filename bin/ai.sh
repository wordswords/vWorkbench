#!/bin/bash
set -e
shopt -s lastpipe
read -r input;
openai_pipe ${input} | tee >(xclip.sh)

