#!/usr/bin/env bash
#
# Block a website by mapping its bare domain and www subdomain to loopback
# addresses (0.0.0.0 and ::0) in /etc/hosts. Must be run as root.

set -euo pipefail
IFS=$'\n\t'

if [[ $(id -u) -ne 0 ]] ; then
    printf '%s\n' 'You must be root to run this script'
    exit 1
fi

SITE="${1}"
WWW="www.${SITE}"
printf '0.0.0.0 %s\n' "${WWW}" | sudo tee -a /etc/hosts > /dev/null
printf '0.0.0.0 %s\n' "${SITE}" | sudo tee -a /etc/hosts > /dev/null
printf '::0 %s\n' "${SITE}" | sudo tee -a /etc/hosts > /dev/null
printf '::0 %s\n' "${WWW}" | sudo tee -a /etc/hosts > /dev/null

printf 'Blocked %s and %s\n' "${WWW}" "${SITE}"

