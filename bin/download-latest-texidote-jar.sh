#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# TEXIDOTE_VERSION can be set via the environment (exported by deploy.sh).
TEXIDOTE_VERSION="${TEXIDOTE_VERSION:-0.8.3}"

readonly DOTFILES_DIR="${HOME}/.dotfiles"
TARGET="${DOTFILES_DIR}/textidote.jar"

rm -f "${TARGET}"
wget -O "${TARGET}" \
    "https://github.com/sylvainhalle/textidote/releases/download/v${TEXIDOTE_VERSION}/textidote.jar"
chmod 700 "${TARGET}"
