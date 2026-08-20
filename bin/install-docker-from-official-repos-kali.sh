#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly DOCKER_REPO_URL="https://download.docker.com/linux/centos/docker-ce.repo"

# Install Docker on AlmaLinux
sudo dnf install -y dnf-utils
sudo dnf config-manager --add-repo "${DOCKER_REPO_URL}"
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker --now
