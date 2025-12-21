#!/bin/bash

set -e
set -x

if [ "$#" -eq 0 ]; then
  echo "Usage: "$0" <url of base directory to download" >&2
  exit 1
fi

cd /home/incominggames
wget -m -np -c -e robots=off -R index.html* "$1"
