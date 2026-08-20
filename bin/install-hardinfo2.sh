#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly HARDINFO_LOG="hardinfo2.log"

sudo dnf install -y epel-release
sudo dnf install -y hardinfo sysbench
hardinfo | tee "${HARDINFO_LOG}"

