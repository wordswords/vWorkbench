#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# This requires a machine-alias already setup by deploy-remote-home.sh in the same directory.

shopt -s expand_aliases
# shellcheck source=/dev/null
source ~/.zsh_aliases
if [ $# -eq 2 ]; then
  # parameters
  MACHINE_ALIAS=$1
  USERNAME_TO_GRANT=$2
  USER=${USER}
else
  echo "grant-sudo-remote.sh <machine-alias> <username-on-machine-to-grant-sudo-to>"
  exit 1
fi
rm /tmp/grant-sudo-tmp-file.txt || echo ""
${MACHINE_ALIAS} sudo -S whoami | tee /tmp/grant-sudo-tmp-file.txt
if grep -q root /tmp/grant-sudo-tmp-file.txt ; then
  echo We have root on "${MACHINE_ALIAS}". Finding out sudo group..
  rm /tmp/grant-sudo-tmp-file.txt

  # get the sudo group
  "${MACHINE_ALIAS}" sudo -S groups "${USER}" | tee /tmp/grant-sudo-tmp-file.txt
  # remove interactive terminal stuff
  sed -ie '/.*password for.*/d' /tmp/grant-sudo-tmp-file.txt

  # if the sudo group is called 'sudo'
  grep -q sudo /tmp/grant-sudo-tmp-file.txt && "${MACHINE_ALIAS}" sudo -S usermod -aG sudo "${USERNAME_TO_GRANT}"

  # if the sudo group is called 'wheel'
  grep -q wheel /tmp/grant-sudo-tmp-file.txt && "${MACHINE_ALIAS}" sudo -S usermod -aG wheel "${USERNAME_TO_GRANT}"

  rm /tmp/grant-sudo-tmp-file.txt
  exit 0
else
  echo We are not root on "${MACHINE_ALIAS}" exiting..
  rm /tmp/grant-sudo-tmp-file.txt || echo ""
  exit 1
fi
