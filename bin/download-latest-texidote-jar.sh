#!/bin/bash

set -x
set -e

cd ~/.dotfiles
rm -f *.jar || true
wget -O ~/.dotfiles/textidote.jar https://github.com/sylvainhalle/textidote/releases/download/v0.8.3/textidote.jar
chmod 700 ~/.dotfiles/textidote.jar

