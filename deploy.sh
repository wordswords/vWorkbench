#!/bin/bash

set -e

./deploy-part-0.zsh # pre requisite packages install
./deploy-part-1.sh # oh my zsh install
./deploy-part-2.zsh # all other customisations

echo "Done."


