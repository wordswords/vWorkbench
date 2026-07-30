#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [[ $(id -u) -ne 0 ]] ; then
    printf '%s\n' 'You must be root to run this script'
    exit 1
fi

SITE=${1}
WWW=www.${SITE}

grep -v "${SITE}" < /etc/hosts | sudo tee /etc/hosts.new > /dev/null
sudo mv /etc/hosts.new /etc/hosts

printf 'Unblocked %s and %s\n' "${WWW}" "${SITE}"

