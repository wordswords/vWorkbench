#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

shopt -s expand_aliases
source ~/.zsh_aliases
if [ $# -eq 2 ]; then
  # parameters passed on command line
  MACHINE_ALIAS=$1
  USERNAME=$2
  USER=${USER}
else
  echo "add-to-group.sh <machine-alias> <username>"
  exit 1
fi
rm /tmp/grant-sudo-tmp-file.txt || echo ""
${MACHINE_ALIAS} sudo -S whoami | tee /tmp/grant-sudo-tmp-file.txt
if grep -q root /tmp/grant-sudo-tmp-file.txt ; then
  echo "We have root on ${MACHINE_ALIAS}."
  rm /tmp/grant-sudo-tmp-file.txt

  ${MACHINE_ALIAS} sudo -S groups ${USERNAME}

  exit 0
else
  rm /tmp/grant-sudo-tmp-file.txt || echo ""
  echo "We are not root on ${MACHINE_ALIAS}. exiting.."
  exit 1
fi
