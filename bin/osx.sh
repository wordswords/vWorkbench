#!/bin/bash

# For when you want to use osx
# Needs 40GB or so free

set -e

sudo apt install qemu qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager libguestfs-tools -y

docker pull sickcodes/docker-osx:auto
docker run -it --device /dev/kvm \
    -p 50922:10022 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e "DISPLAY=${DISPLAY:-:0.0}" \
    -e GENERATE_UNIQUE=true \
    -e TERMS_OF_USE=i_agree \
    sickcodes/docker-osx:auto


