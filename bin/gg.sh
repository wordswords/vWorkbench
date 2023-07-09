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
    elif [ "$(get_os)" == "linux" ]; then
        export FIREFOX_BIN="firefox"
    elif [ "$(get_os)" == "osx" ]; then
        export FIREFOX_BIN="/Applications/Firefox.app/Contents/MacOS/firefox"
    else
        echo "Unknown OS"
        exit 1
    fi
}

google () {
    TLD=".co.uk"
    search=""
    encoded=""
    for term in "$@"; do
        search="${search}%20${term}"
    done
    encoded=$(jq -rn --arg x '${search}' '$x|@uri')
    "${FIREFOX_BIN}" "https://www.google${TLD}/search?q=${encoded}" &
}

set_firefox_path
google "${input}"

