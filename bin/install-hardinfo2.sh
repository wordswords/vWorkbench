#!/bin/bash

set -e
set -x

wget https://github.com/hardinfo2/hardinfo2/releases/download/release-2.1.10pre/hardinfo2_2.1.10-Ubuntu-22.04_amd64.deb
sudo apt install ./hardinfo2*.deb -y
sudo apt install sysbench -y
hardinfo2 | tee hardinfo2.log

