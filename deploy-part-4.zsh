#!/bin/bash

set -e

# uninstall
rm -rf ./lieer
rm -rf ${HOME}/mail
rm -rf ${HOME}/.mail

# install lieer+notmuch
mkdir -p ${HOME}/mail

git clone git@github.com:gauteh/lieer.git
cd lieer
pip install notmuch
pip install google_api_python_client
pip install oauth2client
pip install tqdm
#pip install from git+ssh://git@github.com/weilbith/notmuch2-python-bindings
sudo apt install python3-notmuch2
sudo apt install notmuch
pip install .

# configure notmuch
notmuch new
notmuch setup

# configure lieer
mkdir -p ~/.mail/account.gmail
cd ~/mail
gmi init contact@davidcraddock.net
gmi pull

