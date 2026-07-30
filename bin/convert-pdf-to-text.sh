#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

ebook-convert "$1" "$1".txt
