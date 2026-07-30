#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sudo DEBIAN_FRONTEND=noninteractive apt-get update --allow-downgrades -y
sudo DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade --assume-yes --allow-downgrades -y --option "Dpkg::Options::=--force-confdef" \
  --option "Dpkg::Options::=--force-confold"
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade --assume-yes --allow-downgrades -y --option "Dpkg::Options::=--force-confdef" \
  --option "Dpkg::Options::=--force-confold"
