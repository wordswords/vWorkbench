#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Install ADOM - Ancient Domains of Mystery - my 'desert island' game

# ADOM_VERSION can be set via the environment (exported by deploy.sh).
ADOM_VERSION="${ADOM_VERSION:-3.3.3}"

sudo dnf install -y ncurses-libs
wget "https://www.adom.de/home/download/current/adom_linux_ubuntu_64_${ADOM_VERSION}.tar.gz"
tar xzf "adom_linux_ubuntu_64_${ADOM_VERSION}.tar.gz"
cp ./adom*/adom ~/bin
rm -rf ./adom*

