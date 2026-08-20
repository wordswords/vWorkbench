#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Run OCR on an image using pytesseract (installing tesseract if needed).
image_path="${1:?Usage: $0 <image>}"

sudo dnf install -y tesseract &> /dev/null
# Pillow provides the PIL.Image module that imageocr.py calls Image.open on.
pip install --break-system-packages pytesseract Pillow &> /dev/null
python3 "${HOME}/.dotfiles/bin/imageocr.py" "${image_path}"

