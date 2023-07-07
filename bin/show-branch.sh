#!/bin/bash -e

cd "$1"
cd ..
GBRANCH="$(git branch --show-current)"

if [ "${GBRANCH}" = "master" ] || [ "${GBRANCH}" = "main"  ]; then
    printf " -- \033[0;31m["
    echo -n $(git branch --show-current)
    printf "]\033[0m \n"
else
    printf " -- \033[0;34m["
    echo -n $(git branch --show-current)
    printf "]\033[0m \n"
fi

