#!/bin/bash
set -x
set -e

tmpdir=$(mktemp -d)
cd ${tmpdir}
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
if [ -d /usr/local/aws-cli ]; then
    sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
else
    sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli
fi
cd -
rm -rf ${tmpdir}

