#!/bin/bash
set -x
set -e
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

gsearch () {
    TLD=".co.uk"
    encoded=""
    os="$(get_os)"
    FIREFOX_BIN=""
    if [ "$os" == "windows" ]; then
        FIREFOX_BIN="/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe"
    elif [ "$os" == "linux" ]; then
        FIREFOX_BIN="firefox"
    elif [ "$os" == "osx" ]; then
        FIREFOX_BIN="/Applications/Firefox.app/Contents/MacOS/firefox"
    else
        echo "Unknown OS"
        exit 1
    fi
    ~/bin/urlencode.py
    encoded=$(head -c 1000 /tmp/googlesearchvimencoded)
    url="https://www.google${TLD}/search?q=${encoded}"
    #rm -rf /tmp/googlesearchvim*
    sleep 1
    eval "${FIREFOX_BIN}" "${url}"
}

gsearch

