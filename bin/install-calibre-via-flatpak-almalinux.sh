#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly FLATHUB_REPO="https://flathub.org/repo/flathub.flatpakrepo"
readonly ZSHRC="${HOME}/.zshrc"
readonly CALIBRE_ALIAS='alias calibre="flatpak run com.calibre_ebook.calibre"'

sudo flatpak remote-add --if-not-exists flathub "${FLATHUB_REPO}"
sudo flatpak install flathub com.calibre_ebook.calibre

# Make the calibre alias available in future zsh sessions (idempotent)
if ! grep -qF "${CALIBRE_ALIAS}" "${ZSHRC}"; then
    echo "${CALIBRE_ALIAS}" >> "${ZSHRC}"
fi
