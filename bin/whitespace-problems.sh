#!/bin/bash

set -e

# remove newlines from start of file and end of file
find . -type f -exec sed -i -e '/./,$!d' -e ':a' -e '/^ *$/{$d;N;ba' -e '} {}' \;
# remove trailing whitespace from all files
find . -name *.md -type f -exec sed -i s/[ 	]*$// {} \;

