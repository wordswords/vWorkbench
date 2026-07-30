#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# For when you want to use osx
# Needs 40GB or so free

sudo dnf install -y qemu-kvm libvirt virt-manager libguestfs-tools

docker pull sickcodes/docker-osx:auto
docker run -it --device /dev/kvm \
    -p 50922:10022 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e "DISPLAY=${DISPLAY:-:0.0}" \
    -e GENERATE_UNIQUE=true \
    -e TERMS_OF_USE=i_agree \
    sickcodes/docker-osx:auto

