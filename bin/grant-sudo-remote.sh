#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# This requires a machine-alias already setup by deploy-remote-home.sh in the same directory.

shopt -s expand_aliases
# shellcheck source=/dev/null
source ~/.zsh_aliases
if [[ $# -eq 2 ]]; then
  # parameters
  MACHINE_ALIAS=$1
  USERNAME_TO_GRANT=$2
  USER=${USER}
else
  printf '%s\n' "grant-sudo-remote.sh <machine-alias> <username-on-machine-to-grant-sudo-to>"
  exit 1
fi
rm -f /tmp/grant-sudo-tmp-file.txt
${MACHINE_ALIAS} sudo -S whoami | tee /tmp/grant-sudo-tmp-file.txt
if grep -q root /tmp/grant-sudo-tmp-file.txt ; then
  printf 'We have root on %s. Finding out sudo group..\n' "${MACHINE_ALIAS}"
  rm -f /tmp/grant-sudo-tmp-file.txt

  # get the sudo group
  "${MACHINE_ALIAS}" sudo -S groups "${USER}" | tee /tmp/grant-sudo-tmp-file.txt
  # remove interactive terminal stuff
  sed -i -e '/.*password for.*/d' /tmp/grant-sudo-tmp-file.txt

  # if the sudo group is called 'sudo'
  if grep -q sudo /tmp/grant-sudo-tmp-file.txt; then
    "${MACHINE_ALIAS}" sudo -S usermod -aG sudo "${USERNAME_TO_GRANT}"
  fi

  # if the sudo group is called 'wheel'
  if grep -q wheel /tmp/grant-sudo-tmp-file.txt; then
    "${MACHINE_ALIAS}" sudo -S usermod -aG wheel "${USERNAME_TO_GRANT}"
  fi

  rm -f /tmp/grant-sudo-tmp-file.txt
  exit 0
else
  printf 'We are not root on %s exiting..\n' "${MACHINE_ALIAS}"
  rm -f /tmp/grant-sudo-tmp-file.txt
  exit 1
fi
