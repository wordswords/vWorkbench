#!/bin/bash
set -e
shopt -s lastpipe
read -r input;
FIREFOX_BIN="/mnt/c/Program Files/Mozilla Firefox/firefox.exe"
google() {
    search=""
    for term in "$@"; do
        search="$search%20$term"
    done
    "${FIREFOX_BIN}" "http://www.google.co.uk/search?q=$search" &
}
google "${input}"

