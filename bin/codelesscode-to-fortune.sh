#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

rm -rf ./codelesscode || true
git clone git@github.com:aldesantis/the-codeless-code.git ./codelesscode
cd ./codelesscode/the-codeless-code/en-qi/
~/bin/concat-all-fortune-files-to-one-file.sh .
mv combined_fortunes codelesscode_fortunes
mv combined_fortunes.dat codelesscode_fortunes.dat
sudo mv codelesscode_fortunes* /usr/local/share/fortune/
cd -
rm -rf ./codelesscode/

