#!/bin/bash

set -e
set -x

sudo dnf install -y curl tar

HUGO_VERSION="$(curl -fsSL https://api.github.com/repos/gohugoio/hugo/releases/latest \
  | grep -Po '"tag_name":\s*"\Kv[^"]+' \
  | sed 's/^v//')"

curl -fL -o /tmp/hugo.tar.gz \
  "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"

sudo tar -xzf /tmp/hugo.tar.gz -C /usr/local/bin hugo
rm /tmp/hugo.tar.gz

hugo version
