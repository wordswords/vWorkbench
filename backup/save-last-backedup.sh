#!/bin/bash

git config --global --add safe.directory /home/david/.dotfiles && \
cd /home/david/.dotfiles/backup && git add .last_successful_backup && \
git commit -m 'Updated last successful backup' && \
git push -f


