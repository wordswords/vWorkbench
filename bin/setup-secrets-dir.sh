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
echo
echo "About to write the following configuration.."
echo "BORG Backup Passphrase: ${VIMZ_BORG_PASSPHRASE}"
echo "Mozilla VPN Token: ${VIMZ_MOZ_VPN_TOKEN}"
echo "OpenAI Access Token: ${VIMZ_OPENAI_ACCESS_TOKEN}"
echo

read -rp "Write this config? (Y/Yes/n/no)" CONFIGWRITE
case "$CONFIGWRITE" in
    Y|y|yes)
    for f in ~/.dotfiles/SECRETS_TEMPLATE_PROC/*
    do
        sed -i "s/__VIMZ_BORG_PASSPHRASE__/${VIMZ_BORG_PASSPHRASE}/g" "${f}"
        sed -i "s/__VIMZ_MOZ_VPN_TOKEN__/${VIMZ_MOZ_VPN_TOKEN}/g" "${f}"
        sed -i "s/__VIMZ_OPENAI_ACCESS_TOKEN__/${VIMZ_OPENAI_ACCESS_TOKEN}/g" "${f}"
        sed -i "s/__VIMZ_USERNAME__/${VIMZ_USERNAME}/g" "${f}"
        sed -i "s/__VIMZ_GITHUB_EMAIL__/${VIMZ_GITHUB_EMAIL}/g" "${f}"
    done
    rm -rf ~/.dotfiles/SECRETS
    mv ~/.dotfiles/SECRETS_TEMPLATE_PROC ~/.dotfiles/SECRETS
    echo "Config saved in ~/.dotfiles/SECRETS/*"
    ;;
    *)
    echo "OK. Exiting.."
    ;;
esac

