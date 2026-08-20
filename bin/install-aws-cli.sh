#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly AWS_CLI_ZIP_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
readonly DOWNLOAD_ARCHIVE="awscliv2.zip"

readonly TMP_DIR
TMP_DIR=$(mktemp -d)
trap 'rm -rf "${TMP_DIR}"' EXIT
cd "${TMP_DIR}"
curl -sS "${AWS_CLI_ZIP_URL}" -o "${DOWNLOAD_ARCHIVE}"
unzip -q "${DOWNLOAD_ARCHIVE}"
if [[ -d /usr/local/aws-cli ]]; then
    sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
else
    sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli
fi

