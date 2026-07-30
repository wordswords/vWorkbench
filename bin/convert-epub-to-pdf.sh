#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

pandoc -f epub -t pdf "$1" --pdf-engine=xelatex -o "$1".pdf
