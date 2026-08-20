#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Deduplicate lines in the google-cloud-sdk yum repo file.
cd /etc/yum.repos.d
uniq < google-cloud-sdk.repo > /tmp/google-cloud-sdk.repo
sudo mv /tmp/google-cloud-sdk.repo google-cloud-sdk.repo
