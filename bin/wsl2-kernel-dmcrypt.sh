#!/bin/bash

set -ex

# From https://gist.github.com/d4v3y0rk/e19d346ec9836b4811d4fecc1e1d5d64
WINDOWS_USER_NAME="conta"

sudo apt install -y build-essential flex bison libssl-dev libelf-dev libncurses5-dev git 
rm -rf ./WSL2-Linux-Kernel || echo ''
git clone https://github.com/microsoft/WSL2-Linux-Kernel.git
cd WSL2-Linux-Kernel
cat /proc/config.gz | gunzip > .config
sed -i "s/#CONFIG_DM_CRYPT is not set/CONFIG_DM_CRYPT=y/g" .config
sudo yes "" | make clean -j
sudo yes "" | make -j
sudo yes "" | make modules_install -j
cp ./arch/x86_64/boot/bzImage /mnt/c/Users/${WINDOWS_USER_NAME}/
echo """
[wsl2]
   kernel=C:\\Users\\${WINDOWS_USER_NAME}\\bzImage
   swap=0
   localhostForwarding=true
""" > /mnt/c/Users/${WINDOWS_USER_NAME}/.wslconfig
echo "Now exit and restart WSL in powershell by the following command:"
echo "C:\\Users\\${WINDOWS_USER_NAME}\\wsl --shutdown"

