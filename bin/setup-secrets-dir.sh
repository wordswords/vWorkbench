#!/bin/bash

set -e
set -x

rm -rf ~/.dotfiles/SECRETS_TEMPLATE_PROC
cp -r ~/.dotfiles/SECRETS_TEMPLATE ~/.dotfiles/SECRETS_TEMPLATE_PROC
cp -r ~/.dotfiles/SECRETS ~/.dotfiles/.SECRETS_BACKUP || true

echo "Building configuration.."
read -rp "Enter BORG Backup Passphrase:" VIMZ_BORG_PASSPHRASE
read -rp "Enter Mozilla VPN Token:" VIMZ_MOZ_VPN_TOKEN
read -rp "Enter OpenAI Access Token:" VIMZ_OPENAI_ACCESS_TOKEN
read -rp "Enter Ubuntu username for user you want to install Vimz to:" VIMZ_USERNAME
read -rp "Enter email address for your Github account:" VIMZ_GITHUB_EMAIL
read -rp "Enter the Joplin Cloud sync password:" VIMZ_JOPLIN_SYNC_PASSWORD
read -rp "Enter your OpenAPI Project API Key:" VIMZ_OPENAI_ACCESS_TOKEN
echo
echo "About to write the following configuration.."
echo "BORG Backup Passphrase: ${VIMZ_BORG_PASSPHRASE}"
echo "Mozilla VPN Token: ${VIMZ_MOZ_VPN_TOKEN}"
echo "OpenAI Project API Key: ${VIMZ_OPENAI_ACCESS_TOKEN}"
echo "Ubuntu username: ${VIMZ_USERNAME}"
echo "Github email address: ${VIMZ_GITHUB_EMAIL}"
echo "Joplin Cloud sync password:: ${VIMZ_JOPLIN_SYNC_PASSWORD}"
echo
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
    echo "Config saved in ~/.dotfiles/SECRETS/*"
    ;;
    *)
    echo "OK. Exiting.."
    ;;
esac

