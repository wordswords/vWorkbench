#!/usr/bin/env python3
"""URL-encode a file's contents and write the result to a fixed output file.

Reads the first command-line argument as the input file and writes the
percent-encoded text to /tmp/googlesearchencoded (consumed by gg.sh).
"""

import sys
import urllib.parse

INPUT_PATH = sys.argv[1] if len(sys.argv) > 1 else None
OUTPUT_PATH = "/tmp/googlesearchencoded"


def urlencode_file(source_path: str, destination_path: str) -> None:
    """Read ``source_path`` and write its URL-encoded contents."""
    with open(source_path, encoding="utf-8") as source:
        contents = urllib.parse.quote(source.read())

    with open(destination_path, "w+", encoding="utf-8") as destination:
        destination.write(contents)


def main() -> int:
    if INPUT_PATH is None:
        print(f"Usage: {sys.argv[0]} <file-to-url-encode>", file=sys.stderr)
        return 1

    urlencode_file(INPUT_PATH, OUTPUT_PATH)
    return 0


if __name__ == "__main__":
    sys.exit(main())
