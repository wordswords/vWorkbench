#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

declare sha line key value
declare -A kv

unset GIT_PAGER
[[ -t 1 ]] && GIT_PAGER=$(git var GIT_PAGER || :)

unset abbrev
abbrev=$(git config core.abbrev || :)
[[ $abbrev == +([0-9]) ]] || abbrev=10

git blame --line-porcelain "$@" | {
    while read -r sha _; do
        kv=()
        unset line
        while IFS= read -r line; do
            [[ $line != $'\t'* ]] || break
            read -r key value <<<"$line"
            kv[$key]=$value
        done
        [[ -n ${line:+set} ]] || break
        printf "%-${abbrev}.${abbrev}s (%-40.40s) %s\\n" "$sha" "${kv[summary]:-}" "${line#$'\t'}"
    done
} | eval "${GIT_PAGER:-cat}"
