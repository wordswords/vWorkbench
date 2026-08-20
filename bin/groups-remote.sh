#!/usr/bin/env bash
#
# List the groups a given user belongs to on a remote machine.
# Requires a machine alias and sudo access (via the sudo group) on the target.

set -euo pipefail
IFS=$'\n\t'

shopt -s expand_aliases
# shellcheck source=/dev/null
source ~/.zsh_aliases

TMP_FILE=/tmp/grant-sudo-tmp-file.txt

cleanup_tmp_file() {
    rm -f "${TMP_FILE}"
}

has_root() {
    grep -q root "${TMP_FILE}"
}

print_usage() {
    echo "groups-remote.sh <machine-alias> <username>"
}

if [[ "$#" -ne 2 ]]; then
    print_usage
    exit 1
fi

# parameters passed on command line
machine_alias=$1
username=$2

cleanup_tmp_file
"${machine_alias}" sudo -S whoami | tee "${TMP_FILE}"

if has_root; then
    echo "We have root on ${machine_alias}."
    cleanup_tmp_file

    "${machine_alias}" sudo -S groups "${username}"

    exit 0
else
    cleanup_tmp_file
    echo "We are not root on ${machine_alias}. exiting.."
    exit 1
fi
