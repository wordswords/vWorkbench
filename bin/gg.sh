#!/bin/bash
set -x
set -e
args="$@"

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

gsearchstart () {
    if [ -f '/tmp/googlesearchvim' ] ; then
        gsearchmain "/tmp/googlesearchvim"
        rm -f /tmp/googlesearchvim
    else
        echo "$@" > /tmp/googlesearchcmdline
        gsearchmain "/tmp/googlesearchcmdline"
        rm -f /tmp/googlesearchcmdline
    fi
    rm -f /tmp/googlesearchencoded
}

gsearchmain () {
    filetoencode="$1"
    echo "File to Encode $1"
    echo "Contents: "
    cat "${filetoencode}"
    TLD=".co.uk"
    encoded=""
    os="$(get_os)"
    FIREFOX_BIN=""
    if [ "$os" == "windows" ]; then
        FIREFOX_BIN="/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe"
    elif [ "$os" == "linux" ]; then
        FIREFOX_BIN="/snap/bin/firefox"
    elif [ "$os" == "osx" ]; then
        FIREFOX_BIN="/Applications/Firefox.app/Contents/MacOS/firefox"
    else
        echo "Unknown OS"
        exit 1
    fi
    ~/bin/urlencode.py "${filetoencode}"
    encoded=$(head -c 1000 /tmp/googlesearchencoded)
    url="https://www.google${TLD}/search?q=${encoded}"
    sleep 1
    eval "${FIREFOX_BIN}" "${url}"
}

gsearchstart "${args}"

