#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

cd /etc/apt/sources.list.d
cat google-cloud-sdk.list | uniq > /tmp/google-cloud-sdk.list
sudo mv /tmp/google-cloud-sdk.list google-cloud-sdk.list
