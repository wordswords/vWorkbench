#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sudo apt install pandoc -y
sudo apt install pdflatex -y
sudo apt install librsvg2-bin -y
sudo apt install texlive-xetex -y

