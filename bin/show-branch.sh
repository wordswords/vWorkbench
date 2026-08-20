#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Prints the current Git branch name, colored red for `master`/`main` and blue
# otherwise. Accepts a path as its first argument and changes to its parent
# before resolving the branch.

cd "$1"
cd ..
current_branch="$(git branch --show-current)"

if [[ "$current_branch" == "master" || "$current_branch" == "main" ]]; then
    printf ' -- \033[0;31m['
    printf '%s' "$(git branch --show-current)"
    printf ']\033[0m \n'
else
    printf ' -- \033[0;34m['
    printf '%s' "$(git branch --show-current)"
    printf ']\033[0m \n'
fi
