#!/bin/bash

set -e
set -x

rm -rf ./codelesscode | echo ''
git clone git@github.com:aldesantis/the-codeless-code.git ./codelesscode
cd ./codelesscode/the-codeless-code/en-qi/
~/bin/fortune.sh .
mv combined_fortunes codelesscode_fortunes
mv combined_fortunes.dat codelesscode_fortunes.dat
sudo mv codelesscode_fortunes* /usr/share/games/fortunes/
cd -
rm -rf ./codelesscode/

