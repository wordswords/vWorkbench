#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Install ADOM - Ancient Domains of Mystery - my 'desert island' game

# ADOM_VERSION can be set via the environment (exported by deploy.sh).
ADOM_VERSION="${ADOM_VERSION:-3.3.3}"
ARCHIVE="adom_linux_ubuntu_64_${ADOM_VERSION}.tar.gz"

sudo dnf install -y ncurses-libs
wget "https://www.adom.de/home/download/current/${ARCHIVE}"
tar xzf "${ARCHIVE}"

# The archive extracts into a versioned adom*/ directory.
sudo install -m 755 ./adom*/adom "${HOME}/bin/adom"
find . -maxdepth 1 -type d -name 'adom*' -exec rm -rf {} +
rm -f "${ARCHIVE}"

