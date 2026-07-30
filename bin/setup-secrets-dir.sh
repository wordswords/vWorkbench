#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

rm -rf ~/.dotfiles/SECRETS_TEMPLATE_PROC
cp -r ~/.dotfiles/SECRETS_TEMPLATE ~/.dotfiles/SECRETS_TEMPLATE_PROC
cp -r ~/.dotfiles/SECRETS ~/.dotfiles/.SECRETS_BACKUP || true

while :; do
    printf '\n Building configuration..\n'
    read -rp "Enter BORG Backup Passphrase: " VIMZ_BORG_PASSPHRASE
    read -rp "Enter Mozilla VPN Token: " VIMZ_MOZ_VPN_TOKEN
    read -rp "Enter OpenAI Access Token: " VIMZ_OPENAI_ACCESS_TOKEN
    read -rp "Enter Ubuntu username for user you want to install Vimz to: " VIMZ_USERNAME
    read -rp "Enter email address for your Github account: " VIMZ_GITHUB_EMAIL
    read -rp "Enter the Joplin Cloud sync password: " VIMZ_JOPLIN_SYNC_PASSWORD
    read -rp "Enter your OpenAPI Project API Key: " VIMZ_OPENAI_ACCESS_TOKEN
    printf '\n'
    printf 'About to write the following configuration..\n'
    printf 'BORG Backup Passphrase: %s\n' "${VIMZ_BORG_PASSPHRASE}"
    printf 'Mozilla VPN Token: %s\n' "${VIMZ_MOZ_VPN_TOKEN}"
    printf 'OpenAI Project API Key: %s\n' "${VIMZ_OPENAI_ACCESS_TOKEN}"
    printf 'Ubuntu username: %s\n' "${VIMZ_USERNAME}"
    printf 'Github email address: %s\n' "${VIMZ_GITHUB_EMAIL}"
    printf 'Joplin Cloud sync password: %s\n' "${VIMZ_JOPLIN_SYNC_PASSWORD}"
    printf '\n'
    read -rp "Write this config? (y/yes/No)" CONFIGWRITE
    case "$CONFIGWRITE" in
        Y|y|Yes|yes)
        for f in ~/.dotfiles/SECRETS_TEMPLATE_PROC/*
        do
            sed -i "s/__VIMZ_BORG_PASSPHRASE__/${VIMZ_BORG_PASSPHRASE}/g" "${f}"
            sed -i "s/__VIMZ_MOZ_VPN_TOKEN__/${VIMZ_MOZ_VPN_TOKEN}/g" "${f}"
            sed -i "s/__VIMZ_OPENAI_ACCESS_TOKEN__/${VIMZ_OPENAI_ACCESS_TOKEN}/g" "${f}"
            sed -i "s/__VIMZ_USERNAME__/${VIMZ_USERNAME}/g" "${f}"
            sed -i "s/__VIMZ_GITHUB_EMAIL__/${VIMZ_GITHUB_EMAIL}/g" "${f}"
            sed -i "s/__VIMZ_JOPLIN_SYNC_PASSWORD__/${VIMZ_JOPLIN_SYNC_PASSWORD}/g" "${f}"
        done
        rm -rf ~/.dotfiles/SECRETS
        mv ~/.dotfiles/SECRETS_TEMPLATE_PROC ~/.dotfiles/SECRETS
        printf 'Config saved in ~/.dotfiles/SECRETS/*\n'
        break;
        ;;
        *)
        printf 'OK. Trying again..\n'
        ;;
    esac
done
