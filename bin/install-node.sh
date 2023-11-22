#!/bin/bash

set -e
set -x

# Install node via Nodesource

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/nodesource.gpg

NODE_MAJOR=20 # version of node to install!
sudo echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo cat /etc/apt/sources.list.d/nodesource.list | sort -u | sudo tee /etc/apt/sources.list.d/nodesource.list.dedupe
sudo mv /etc/apt/sources.list.d/nodesource.list.dedupe /etc/apt/sources.list.d/nodesource.list

sudo apt-get update
sudo apt-get install nodejs -y