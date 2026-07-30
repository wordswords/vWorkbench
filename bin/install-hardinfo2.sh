#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sudo dnf install -y epel-release
sudo dnf install -y hardinfo sysbench
hardinfo | tee hardinfo2.log

