#!/bin/bash

set -e

find /mnt/ebooks -type f -name "*$@*" | sort
echo "--"
echo "Now use epy <path> to open them in the console."


