#!/bin/bash

set -e
set -x

# Install Cmake 3.28.0
#if [ ! -d ./cmake-3.28.0 ] ; then
#    sudo apt-get install build-essential python3-dev libssl-dev -y
#    wget https://github.com/Kitware/CMake/releases/download/v3.28.0/cmake-3.28.0.tar.gz
#    tar xzf cmake-3.28.0.tar.gz
#    cd ./cmake-3.28.0
#    ./bootstrap && make clean && make && sudo make install
#    cd -
#fi

# Assumes node is already installed - Installs all other prereqs for YCM
sudo apt install -y mono-complete golang
sudo apt install -y openjdk-jdk openjdk-23-jre || sudo apt-get install default-jdk default-jre

# Install YCM
sudo rm -rf ~/.vim/bundle/YouCompleteMe | true
mkdir -p ~/.vim/bundle/YouCompleteMe
chmod -R 700 ~/.vim/bundle/YouCompleteMe/ | true
cd ~/.vim/bundle/YouCompleteMe/
git clone git@github.com:ycm-core/YouCompleteMe.git ./
cd ~/.vim/bundle/YouCompleteMe/
git submodule update --init --recursive
python3 install.py --cs-completer --java-completer --ts-completer

