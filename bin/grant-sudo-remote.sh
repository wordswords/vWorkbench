#!/usr/bin/env bash
#
# Grant sudo access to an existing user on a remote machine by adding them
# to the target system's sudo group (either 'sudo' or 'wheel').
# Requires a machine-alias already set up by deploy-remote-home.sh in the same directory.

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
    printf '%s\n' "grant-sudo-remote.sh <machine-alias> <username-on-machine-to-grant-sudo-to>"
}

if [[ "$#" -ne 2 ]]; then
    print_usage
    exit 1
fi

# parameters
machine_alias=$1
username_to_grant=$2

cleanup_tmp_file
"${machine_alias}" sudo -S whoami | tee "${TMP_FILE}"

if has_root; then
    printf 'We have root on %s. Finding out sudo group..\n' "${machine_alias}"
    cleanup_tmp_file

    # get the sudo group
    "${machine_alias}" sudo -S groups "${USER}" | tee "${TMP_FILE}"
    # remove interactive terminal stuff
    sed -i -e '/.*password for.*/d' "${TMP_FILE}"

    # if the sudo group is called 'sudo'
    if grep -q sudo "${TMP_FILE}"; then
        "${machine_alias}" sudo -S usermod -aG sudo "${username_to_grant}"
    fi

    # if the sudo group is called 'wheel'
    if grep -q wheel "${TMP_FILE}"; then
        "${machine_alias}" sudo -S usermod -aG wheel "${username_to_grant}"
    fi

    cleanup_tmp_file
    exit 0
else
    printf 'We are not root on %s exiting..\n' "${machine_alias}"
    cleanup_tmp_file
    exit 1
fi
