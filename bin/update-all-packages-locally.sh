#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# `dnf update` and `dnf upgrade` are aliases for the same operation; run one.
sudo dnf upgrade -y -q
