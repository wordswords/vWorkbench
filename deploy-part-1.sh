#!/usr/bin/env bash
# vim: foldmethod=marker foldmarker=report_progress,report_done
#
# This script is intended to do whatever is necessary to setup a
# working oh-my-zsh environment with the p10k correct prompt.

set -e

# Load in status message printing functions
source ./deploy-common.sh

report_heading 'Deploy Dotfiles: Part 1'
report_progress 'Installing oh-my-zsh'
    cd ~ || exit 1
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
report_done
report_finished 'Deploy Dotfiles: Part 1'

