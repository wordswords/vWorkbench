#!/bin/bash

set -e
set -x


sudo DEBIAN_FRONTEND=noninteractive apt-get update --allow-downgrades -y
sudo DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade --assume-yes --allow-downgrades -y --option "Dpkg::Options::=--force-confdef" \
  --option "Dpkg::Options::=--force-confold"
sudo DEBIAN_FRONTEND=noninteractive apt-get update --assume-yes --allow-downgrades -y --option "Dpkg::Options::=--force-confdef" \
  --option "Dpkg::Options::=--force-confold"
