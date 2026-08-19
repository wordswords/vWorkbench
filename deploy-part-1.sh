#!/usr/bin/env bash
# vim: foldmethod=marker foldmarker=report_progress,report_done
#
# Set up a working oh-my-zsh environment with the p10k prompt.

set -euo pipefail

# Resolve the dotfiles directory so the script works from any cwd.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTFILES_DIR

# shellcheck disable=SC1091
source "${DOTFILES_DIR}/deploy-common.sh"

report_heading 'Deploy Dotfiles: Part 1'

report_progress 'Installing oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
report_done

report_finished 'Deploy Dotfiles: Part 1'
