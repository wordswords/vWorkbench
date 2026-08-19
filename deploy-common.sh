#!/usr/bin/env bash
# Common functions for deploy scripts.

set -euo pipefail

# Shared constants.
readonly PROGRESS_DIR="/tmp/report_progress_message"
readonly MESSAGE_FILE="${PROGRESS_DIR}/message.txt"
readonly TIME_FILE="${PROGRESS_DIR}/starttime.txt"

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

progress_report() {
    local message=$1
    mkdir -p "${PROGRESS_DIR}"
    printf '%s' "${message}" > "${MESSAGE_FILE}"
    printf '%s' "$(date +%s)" > "${TIME_FILE}"
    printf '\n%s[..] %s%s\n' "${C_CYAN}" "${message}" "${C_RESET}"
}

progress_done() {
    local message start_time elapsed
    message="$(<"${MESSAGE_FILE}")"
    start_time="$(<"${TIME_FILE}")"
    elapsed="$(format_duration "$start_time" "$(date +%s)")"
    printf '%s[✔︎]%s %s[%s in %s]%s... %s[DONE]%s\n' \
        "${C_GREEN}" "${C_RESET}" "${C_CYAN}" "${message}" "${elapsed}" "${C_RESET}" "${C_GREEN}" "${C_RESET}"
    rm -rf "${PROGRESS_DIR}"
}

# Given a start and end epoch time, print a human readable duration.
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

# Backwards-compatible aliases for the callers that used the old names.
report_heading() { print_header "$@"; }
report_finished() { print_finished "$@"; }
report_progress() { progress_report "$@"; }
report_done() { progress_done; }
