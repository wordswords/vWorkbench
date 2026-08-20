#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly GITHUB_API_URL="https://api.github.com/repos/dandavison/delta/releases/latest"
readonly DOWNLOAD_ARCH="x86_64-unknown-linux-gnu"

sudo dnf install -y curl tar

DETECTED_VERSION=$(curl -fsSL "${GITHUB_API_URL}" \
  | grep -Po '"tag_name":\s*"\K[^"]+')

readonly TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT
cd "${TMP_DIR}"

readonly ARCHIVE_NAME="delta-${DETECTED_VERSION}-${DOWNLOAD_ARCH}.tar.gz"
readonly EXTRACTED_DIR="delta-${DETECTED_VERSION}-${DOWNLOAD_ARCH}"

curl -fL -O \
  "https://github.com/dandavison/delta/releases/download/${DETECTED_VERSION}/${ARCHIVE_NAME}"

tar -xzf "${ARCHIVE_NAME}"
sudo install -m 0755 "${EXTRACTED_DIR}/delta" /usr/local/bin/delta
