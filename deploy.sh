#!/usr/bin/env bash
# Repeatable deploy script for the latest version of vWorkbench.
#
# To upgrade, `git pull` the vWorkbench directory and re-run this script.
# It avoids needless duplication (e.g. re-downloading unchanged files).

set -euo pipefail

readonly DOTFILES_DIR="$HOME/.dotfiles"

# Refresh the dotfiles repository, then run each deploy stage in order.
(
    cd "${DOTFILES_DIR}"
    git pull
)

"${DOTFILES_DIR}/deploy-part-0.zsh" # prerequisite packages install
"${DOTFILES_DIR}/deploy-part-1.sh"  # oh-my-zsh install
"${DOTFILES_DIR}/deploy-part-2.sh"  # all other customisations

echo "Done."
