#!/usr/bin/env bash

sudo dnf install -y chromium
sudo dnf group install -y "Development Tools"
sudo dnf install -y python3-devel
python3 -m pip install --user appdirs chardet openai


