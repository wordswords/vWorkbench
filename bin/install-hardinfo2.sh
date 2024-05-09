#!/bin/bash

set -e
set -x

wget https://github.com/hardinfo2/hardinfo2/releases/download/release-2.0.17pre/hardinfo2_2.0.17-Ubuntu-22.04_amd64.deb
sudo apt install ./hardinfo2_2.0.17-Ubuntu-22.04_amd64.deb -y

