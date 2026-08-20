#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Install node via Nodesource.
# NODE_MAJOR can be overridden via the environment to target a different branch.
readonly NODE_MAJOR="${NODE_MAJOR:-22}"

curl -fsSL "https://rpm.nodesource.com/setup_${NODE_MAJOR}.x" | sudo bash -
sudo dnf install -y nodejs
