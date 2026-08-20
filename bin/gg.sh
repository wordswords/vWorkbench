#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Opens a Google search for the given query in the system's default Firefox
# install. Allows queries to be supplied on the command line or via a temp
# file written by the editor.

query="$*"

get_os () {
    kernel_name="$(uname -s)"
    case "$kernel_name" in
        Darwin)
            os_family='osx'
            ;;
        *)
            if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
                os_family='windows'
            else
                os_family='linux'
            fi
            ;;
    esac
    printf '%s\n' "$os_family"
}

gsearchstart () {
    if [[ -f '/tmp/googlesearchvim' ]]; then
        gsearchmain "/tmp/googlesearchvim"
        rm -f /tmp/googlesearchvim
    else
        echo "$*" > /tmp/googlesearchcmdline
        gsearchmain "/tmp/googlesearchcmdline"
        rm -f /tmp/googlesearchcmdline
    fi
    rm -f /tmp/googlesearchencoded
}

gsearchmain () {
    input_file="$1"
    echo "File to Encode $1"
    echo "Contents: "
    cat "${input_file}"
    TLD=".co.uk"
    encoded_query=""
    os_family="$(get_os)"
    FIREFOX_BIN=""
    if [[ "$os_family" == "windows" ]]; then
        FIREFOX_BIN="/mnt/c/Program Files/Mozilla Firefox/firefox.exe"
    elif [[ "$os_family" == "linux" ]]; then
        FIREFOX_BIN="/snap/bin/firefox"
    elif [[ "$os_family" == "osx" ]]; then
        FIREFOX_BIN="/Applications/Firefox.app/Contents/MacOS/firefox"
    else
        echo "Unknown OS"
        exit 1
    fi
    ~/bin/urlencode.py "${input_file}"
    encoded_query="$(head -c 1000 /tmp/googlesearchencoded)"
    search_url="https://www.google${TLD}/search?q=${encoded_query}"
    sleep 1
    eval "${FIREFOX_BIN}" "${search_url}"
}

gsearchstart "${query}"

