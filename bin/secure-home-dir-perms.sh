#!/bin/bash

set -e
set -x

# This should be all that is needed for home directories.

sudo chown -R "${USER}":"${USER}" "${HOME}"
sudo chmod -R 770 "${HOME}"
sudo chmod -R 700 "${HOME}"/.dotfiles/SECRETS
sudo chmod -R 700 "${HOME}"/.secure
sudo chmod -R 700 "${HOME}"/.ssh




