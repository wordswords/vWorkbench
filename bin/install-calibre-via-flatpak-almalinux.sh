#!/usr/bin/env bash

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub com.calibre_ebook.calibre
echo 'alias calibre="flatpak run com.calibre_ebook.calibre"'  >> ~/.zshrc

