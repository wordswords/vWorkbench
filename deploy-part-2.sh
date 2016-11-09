#!/bin/bash

# To be run after installation of oh-my-zsh

rm -rf ~/.zshrc # remove the default .zshrc generated by the oh-my-zsh install

ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.vim ~/.vim
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.bash_profile ~/.bash_profile

# install vim plugins latest version

rm -rf ~/.dotfiles/.vim/bundle/*
cd ~/.dotfiles/.vim/bundle/
git clone git@github.com:/altercation/vim-colors-solarized.git
git clone git@github.com:/vim-scripts/Conque-Shell.git
git clone git@github.com:/ryanoasis/vim-devicons.git
git clone git@github.com:/tpope/vim-rails.git
git clone git@github.com:/tpope/vim-bundler.git
git clone git@github.com:/vim-airline/vim-airline
git clone git@github.com:/scrooloose/nerdtree.git
git clone git@github.com:vim-syntastic/syntastic.git

# install font for vim-fonts
cd ~/Library/Fonts
curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.otf
cd -
echo "If using iterm2, remember to now manually set your font in iterm2 settings to Droid Sans Mono for Powerline both for ASCII and non-ASCII font types!"
