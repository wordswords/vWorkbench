#!/usr/bin/env python3
"""Extract text from an image via pytesseract (Tesseract OCR).

Usage:
    imageocr.py <image-path>

Depends on the `pytesseract` and `Pillow` packages and the `tesseract`
binary (installed by bin/imageocr.sh).
"""

import sys

import pytesseract
from PIL import Image


def ocr_text(image_path: str) -> str:
    """Return the Tesseract-extracted text from ``image_path``.

    Propagates exceptions to the caller; the CLI wrapper reports them.
    """
    with Image.open(image_path) as image:
        return pytesseract.image_to_string(image)


def main() -> int:
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <image-to-extract>", file=sys.stderr)
        return 1

    image_path = sys.argv[1]
    try:
        text = ocr_text(image_path)
    except Exception as error:  # noqa: BLE001 - report any OCR/image failure
        print(f"Error: {error}", file=sys.stderr)
        return 1

    print("Extracted Text:\n", text)
    return 0


if __name__ == "__main__":
    sys.exit(main())
