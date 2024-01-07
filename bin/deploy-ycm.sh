#!/bin/bash

set -e
set -x

# Install Cmake 3.28.0
sudo apt-get install build-essential python3-dev libssl-dev
wget https://github.com/Kitware/CMake/releases/download/v3.28.0/cmake-3.28.0.tar.gz
tar xzf cmake-3.28.0.tar.gz
cd ./cmake-3.28.0
./bootstrap && make clean && make && sudo make install
cd -
rm -rf ./cmake*

# Assumes node is already installed - Installs all other prereqs for YCM
sudo apt-get install -y mono-complete golang openjdk-19-jdk openjdk-19-jre

# Install YCM
rm -rf ~/.vim/bundle/YouCompleteMe | true
mkdir -p ~/.vim/bundle/YouCompleteMe
chmod -R 700 ~/.vim/bundle/YouCompleteMe/ | true
cd ~/.vim/bundle/YouCompleteMe/
git clone git@github.com:ycm-core/YouCompleteMe.git ./
cd ~/.vim/bundle/YouCompleteMe/
git submodule update --init --recursive
python3 install.py --all

