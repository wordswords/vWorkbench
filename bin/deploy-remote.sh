#!/bin/bash

##
### Script to copy local public ssh key to a given host
### and setup an alias in ~/.zsh_aliases and ~/.bash_aliases
### for quick keyed login
##

# get parameters
if [ $# -eq 2 ]; then
  # parameters passed on command line
  HOST_TO_DEPLOY=$1
  ALIAS=$2
else
  echo "Hostname or IP address of machine to deploy to. (Must have a user account named ${USER} already setup):"
  read -r HOST_TO_DEPLOY
  echo "Current list of aliases:"
  echo
  cat ~/.bash_aliases
  echo
  echo "Pick a short memorable unique bash and zsh alias for this new host:"
  read -r ALIAS
  echo "Shall we go ahead deploying to ${USER}@${HOST_TO_DEPLOY} and memorable alias: ${ALIAS}? (y/N)"
  read -r answer
  if echo "${answer}" | grep -iq "^y" ;then
    echo "Proceeding..";
  else
    echo "Quitting..";
    exit;
  fi
fi

# deploy ssh keys
rsync -ave ssh ~/.ssh "${USER}@${HOST_TO_DEPLOY}:~/"
rsync -ave ssh ~/.bash_aliases "${USER}@${HOST_TO_DEPLOY}:~/"

# keyed ssh login
ssh "${USER}@${HOST_TO_DEPLOY}" "mkdir -p ~/.ssh"
cat ~/.ssh/id_rsa.pub | ssh "${USER}@${HOST_TO_DEPLOY}" 'cat >> .ssh/authorized_keys'
ssh "${USER}@${HOST_TO_DEPLOY}" "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"

# update aliases.. we use functions as aliases so we can expand in scripts
echo "${ALIAS} () { /usr/bin/env ssh -t ${USER}@${HOST_TO_DEPLOY} \"\$@\" ;}" >> /tmp/new_aliases

echo -n >> /tmp/new_aliases
cat /tmp/new_aliases >> ~/.zsh_aliases
cat /tmp/new_aliases >> ~/.bash_aliases
rm /tmp/new_aliases
sort -u ~/.bash_aliases -o ~/.bash_aliases.tmp
sort -u ~/.zsh_aliases -o ~/.zsh_aliases.tmp
mv ~/.bash_aliases.tmp ~/.bash_aliases
mv ~/.zsh_aliases.tmp ~/.zsh_aliases
# shellcheck source=/dev/null
source ~/.zsh_aliases
# clean up
echo
echo "New list of your aliases:"
echo
cat ~/.zsh_aliases
echo
echo "Completed. Ready to try new alias: ${ALIAS} . Press any key to continue.."
read -r answer

# shellcheck source=/dev/null
source ~/.zsh_aliases
