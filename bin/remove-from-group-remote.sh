#!/usr/bin/env bash
#
# Remove an existing user on a remote machine from a supplementary group.
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
    echo "remove-from-group-remote.sh <machine-alias> <username-to-process> <group-to-remove>"
}

if [[ "$#" -ne 3 ]]; then
    print_usage
    exit 1
fi

# parameters passed on command line
machine_alias=$1
username_to_process=$2
group_to_remove=$3

cleanup_tmp_file
"${machine_alias}" sudo -S whoami | tee "${TMP_FILE}"

if has_root; then
    echo "We have root on ${machine_alias}."
    cleanup_tmp_file

    "${machine_alias}" sudo -S gpasswd -d "${username_to_process}" "${group_to_remove}"

    exit 0
else
    cleanup_tmp_file
    echo "We are not root on ${machine_alias}. exiting.."
    exit 1
fi
