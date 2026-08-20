#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

tmpdir=$(mktemp -d)
trap 'rm -rf "${tmpdir}"' EXIT
cd "${tmpdir}"
curl -sS "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
if [[ -d /usr/local/aws-cli ]]; then
    sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
else
    sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli
fi

