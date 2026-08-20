#!/usr/bin/env bash
# Repeatable deploy script for the latest version of vWorkbench.
#
# To upgrade, `git pull` the vWorkbench directory and re-run this script.
# It avoids needless duplication (e.g. re-downloading unchanged files).

set -euo pipefail

readonly DOTFILES_DIR="$HOME/.dotfiles"

# ---------------------------------------------------------------------------
# Centralised version pins.
#
# Change these values to have the corresponding tool downloaded and built at a
# different version. They are exported so the deploy stages (and the bin/*
# scripts they invoke) can pick them up via ${VIM_VERSION:-default} etc.
# ---------------------------------------------------------------------------
export VIM_VERSION="9.2.0272"
export ERLANG_OTP_VERSION="29.0.5"
export ELIXIR_VERSION="1.20-latest"
export PYTHON_VERSION="3.12.0"
export TEXIDOTE_VERSION="0.8.3"
export ADOM_VERSION="3.3.3"
export JIRA_CLI_GO_VERSION="go1.19"

# Refresh the dotfiles repository, then run each deploy stage in order.
(
    cd "${DOTFILES_DIR}"
    git pull
)

"${DOTFILES_DIR}/deploy-part-0.zsh" # prerequisite packages install
"${DOTFILES_DIR}/deploy-part-1.sh"  # oh-my-zsh install
"${DOTFILES_DIR}/deploy-part-2.sh"  # all other customisations

echo "Done."
