#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly ZSHRC="${HOME}/.zshrc"
readonly PATH_EXPORT='export PATH="$PATH:$(go env GOPATH)/bin"'

# Install Go if it is not already available
sudo dnf install -y golang

# Install shfmt for your user
go install mvdan.cc/sh/v3/cmd/shfmt@latest

# Make it available in future zsh sessions (idempotent)
if ! grep -qF "${PATH_EXPORT}" "${ZSHRC}"; then
    echo "${PATH_EXPORT}" >> "${ZSHRC}"
fi
source "${ZSHRC}"

# Verify
shfmt --version
