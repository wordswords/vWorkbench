#!/usr/bin/env bash
#
# Copy the local public SSH key to a given host and register a shell
# function alias in ~/.zsh_aliases and ~/.bash_aliases for keyed login.

set -euo pipefail
IFS=$'\n\t'

readonly BASH_ALIASES_FILE="$HOME/.bash_aliases"
readonly ZSH_ALIASES_FILE="$HOME/.zsh_aliases"

usage() {
    echo "Usage: $0 [host] [alias]" >&2
    echo "  host   Hostname or IP of the target machine." >&2
    echo "  alias  Short, memorable name for the login function." >&2
    exit 1
}

confirm() {
    local prompt=$1
    local answer
    read -r -p "${prompt} (y/N) " answer
    [[ "${answer}" =~ ^[Yy] ]]
}

set_alias_from_args() {
    if (($# == 2)); then
        HOST_TO_DEPLOY=$1
        ALIAS=$2
    elif (($# != 0)); then
        usage
    fi
}

read_alias_interactively() {
    echo "Hostname or IP address of machine to deploy to (must have a user account named ${USER} already set up):"
    read -r HOST_TO_DEPLOY

    echo
    echo "Current list of aliases:"
    cat "${BASH_ALIASES_FILE}"

    echo
    echo "Pick a short, memorable, unique bash and zsh alias for this new host:"
    read -r ALIAS

    if confirm "Deploy to ${USER}@${HOST_TO_DEPLOY} with alias '${ALIAS}'?"; then
        echo "Proceeding.."
    else
        echo "Quitting.."
        exit 0
    fi
}

deploy_ssh_key() {
    rsync -ave ssh "$HOME/.ssh" "${USER}@${HOST_TO_DEPLOY}:~/"
    rsync -ave ssh "${BASH_ALIASES_FILE}" "${USER}@${HOST_TO_DEPLOY}:~/"

    ssh "${USER}@${HOST_TO_DEPLOY}" "mkdir -p ~/.ssh"
    ssh "${USER}@${HOST_TO_DEPLOY}" 'cat >> ~/.ssh/authorized_keys' < "$HOME/.ssh/id_rsa.pub"
    ssh "${USER}@${HOST_TO_DEPLOY}" "chmod 700 ~/.ssh; chmod 640 ~/.ssh/authorized_keys"
}

append_alias() {
    local alias_line
    alias_line="${ALIAS} () { /usr/bin/env ssh -t ${USER}@${HOST_TO_DEPLOY} \"\$@\" ; }"

    printf '%s\n' "${alias_line}" >> "${BASH_ALIASES_FILE}"
    printf '%s\n' "${alias_line}" >> "${ZSH_ALIASES_FILE}"
}

deduplicate_file() {
    local file=$1
    local tmp
    tmp="$(mktemp)"
    sort -u "${file}" -o "${tmp}"
    mv "${tmp}" "${file}"
}

main() {
    set_alias_from_args "$@"
    if [[ -z "${HOST_TO_DEPLOY:-}" ]]; then
        read_alias_interactively
    fi

    deploy_ssh_key
    append_alias
    deduplicate_file "${BASH_ALIASES_FILE}"
    deduplicate_file "${ZSH_ALIASES_FILE}"

    echo
    echo "New list of your aliases:"
    cat "${ZSH_ALIASES_FILE}"

    echo
    echo "Completed. Ready to try new alias: ${ALIAS}. Press any key to continue.."
    read -r answer
}

main "$@"
