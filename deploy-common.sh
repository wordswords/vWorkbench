#!/usr/bin/env bash
# Common functions for deploy scripts.

set -euo pipefail

# Are we on a terminal able to render ANSI colour codes?
if [[ -t 1 ]]; then
    readonly C_RESET=$'\e[0m'
    readonly C_RED=$'\e[0;31m'
    readonly C_GREEN=$'\e[0;32m'
    readonly C_CYAN=$'\e[0;36m'
else
    # No colour when output is redirected to a file or a pipe.
    readonly C_RESET=''
    readonly C_RED=''
    readonly C_GREEN=''
    readonly C_CYAN=''
fi

# shellcheck disable=SC2034
export CLICOLOR=1

print_header() {
    local message=$1
    printf '%s[✭] %s [✭]%s\n' "${C_RED}" "${message}" "${C_RESET}"
}

print_finished() {
    local message=$1
    printf '\n%s[✭] %s [✭]%s\n' "${C_GREEN}" "${message}" "${C_RESET}"
}

# Format an epoch duration, given a start and end in seconds.
format_duration() {
    local start=$1
    local end=$2
    local total_seconds=$((end - start))
    local seconds=$((total_seconds % 60))
    local minutes=$((total_seconds / 60 % 60))
    local hours=$((total_seconds / 60 / 60 % 24))
    local days=$((total_seconds / 60 / 60 / 24))

    local parts=()
    ((days > 0)) && parts+=("${days}d")
    ((hours > 0)) && parts+=("${hours}h")
    ((minutes > 0)) && parts+=("${minutes}m")
    parts+=("${seconds}s")

    local IFS=' '
    printf '%s' "${parts[*]}"
}

get_os() {
    local kernel
    kernel="$(uname -s)"

    if [[ "${kernel}" == Darwin ]]; then
        printf 'osx\n'
    elif grep -qEi '(Microsoft|WSL)' /proc/version 2>/dev/null; then
        printf 'windows\n'
    else
        printf 'linux\n'
    fi
}

# The label and start time of the in-progress step. Kept as process-local
# globals rather than shared temp files, so nested/subshell steps can't leak
# state into one another.
__PROGRESS_LABEL=''
__PROGRESS_START=''

report_progress() {
    local message=$1
    __PROGRESS_LABEL="${message}"
    __PROGRESS_START="$(date +%s)"
    printf '\n%s[..] %s%s\n' "${C_CYAN}" "${message}" "${C_RESET}"
}

report_done() {
    local message="${__PROGRESS_LABEL}"
    local start_time="${__PROGRESS_START}"

    if [[ -z "${message}" ]]; then
        printf '%s[✗]%s [report_done called without a matching report_progress]%s\n' \
            "${C_RED}" "${C_RESET}" "${C_RESET}"
        return 1
    fi

    local elapsed
    elapsed="$(format_duration "${start_time}" "$(date +%s)")"
    printf '%s[✔︎]%s %s[%s in %s]%s... %s[DONE]%s\n' \
        "${C_GREEN}" "${C_RESET}" "${C_CYAN}" "${message}" "${elapsed}" "${C_RESET}" \
        "${C_GREEN}" "${C_RESET}"

    __PROGRESS_LABEL=''
    __PROGRESS_START=''
}

# Run a single command under a labelled, timed progress section.
# Usage: step 'Doing the thing' some-command --with args
step() {
    local message=$1
    shift
    report_progress "${message}"
    "$@"
    report_done
}

# Backwards-compatible aliases for callers that used the old names.
report_heading() { print_header "$@"; }
report_finished() { print_finished "$@"; }
