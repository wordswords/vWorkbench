#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# https://www.kali.org/docs/containers/installing-docker-on-kali/
# Add the repository to Apt sources:
printf '%s\n' "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo apt-get install -y docker-compose-plugin

sudo systemctl enable docker --now

