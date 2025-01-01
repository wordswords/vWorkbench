#!/bin/bash

set -e

## This is a repeatable script to deploy the latest version of
## vWorkbench. If you wish to upgrade to the latest version,
## simply do a git pull on the vWorkbench directory and re-run
## this deploy script.

## It should do its best to avoid any unnecessary duplication
## such as downloading files when exactly the same version of
## the file already exists.

./deploy-part-0.zsh # pre requisite packages install
./deploy-part-1.sh # oh my zsh install
./deploy-part-2.zsh # all other customisations

echo "Done."


