#!/bin/bash
set -e
shopt -s lastpipe
read -r input;

get_os () {
  uname_s="$(uname -s)"
  if echo "$uname_s" | grep 'Darwin' >/dev/null
  then
    baseos='osx'
  else
        if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
            baseos='windows'
        else
            baseos='linux'
        fi
  fi
  echo $baseos
}

set_firefox_path () {
    if [ "$(get_os)" == "windows" ]; then
        export FIREFOX_BIN="/mnt/c/Program Files/Mozilla Firefox/firefox.exe"
    fi
    if [ "$(get_os)" == "linux" ]; then
        export FIREFOX_BIN="firefox"
    fi
    if [ "$(get_os)" == "osx" ]; then
        export FIREFOX_BIN="/Applications/Firefox.app/Contents/MacOS/firefox"
    fi
}

google () {
    TLD=".co.uk"
    search=""
    for term in "$@"; do
        search="${search}%20${term}"
    done
    "${FIREFOX_BIN}" "http://www.google${TLD}/search?q=${search}" &
}

set_firefox_path
google "${input}"

