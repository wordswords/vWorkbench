#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly GITHUB_API_URL="https://api.github.com/repos/gohugoio/hugo/releases/latest"
readonly HUGO_ARCHIVE="/tmp/hugo.tar.gz"

sudo dnf install -y curl tar

readonly HUGO_VERSION="$(curl -fsSL "${GITHUB_API_URL}" \
  | grep -Po '"tag_name":\s*"\Kv[^"]+' \
  | sed 's/^v//')"

curl -fL -o "${HUGO_ARCHIVE}" \
  "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"

sudo tar -xzf "${HUGO_ARCHIVE}" -C /usr/local/bin hugo
rm "${HUGO_ARCHIVE}"

hugo version
