#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

imagepath=$1

sudo dnf install -y tesseract &> /dev/null
pip install --break-system-packages pytesseract &> /dev/null
python3 ~/.dotfiles/bin/ocr.py "${imagepath}"

