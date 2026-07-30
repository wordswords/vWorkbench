#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# For when you want to use osx
# Needs 40GB or so free

# Check for package manager
if command -v dnf &>/dev/null; then
    PKG_MANAGER="dnf"
elif command -v yum &>/dev/null; then
    PKG_MANAGER="yum"
elif command -v apt &>/dev/null; then
    PKG_MANAGER="apt"
else
    echo "No supported package manager found (dnf, yum, apt). Exiting."
    exit 1
fi

# Install virtualization packages
if [ "$PKG_MANAGER" = "dnf" ] || [ "$PKG_MANAGER" = "yum" ]; then
    sudo "$PKG_MANAGER" install -y qemu-kvm libvirt virt-manager libguestfs-tools
elif [ "$PKG_MANAGER" = "apt" ]; then
    sudo apt update
    sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager libguestfs-tools
fi

# Check that Docker is installed
if ! command -v docker &>/dev/null; then
    echo "Docker is not installed. Please install Docker and try again."
    exit 1
fi

# Check that the user can run Docker
if ! docker info &>/dev/null; then
    echo "Cannot connect to Docker daemon. Ensure Docker is running and you have permission (e.g., are in the docker group)."
    exit 1
fi

# Check that /dev/kvm exists
if [ ! -e /dev/kvm ]; then
    echo "/dev/kvm not found. KVM acceleration is required. Ensure your CPU supports virtualization and that it is enabled in BIOS."
    exit 1
fi

# Pull the Docker image
echo "Pulling sickcodes/docker-osx:auto..."
if ! docker pull sickcodes/docker-osx:auto; then
    echo "Failed to pull Docker image. Check your network connection and try again."
    exit 1
fi

# Run the container
echo "Starting macOS container..."
docker run -it --rm \
    --device /dev/kvm \
    -p 50922:10022 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e "DISPLAY=${DISPLAY:-:0.0}" \
    -e GENERATE_UNIQUE=true \
    -e TERMS_OF_USE=i_agree \
    sickcodes/docker-osx:auto
