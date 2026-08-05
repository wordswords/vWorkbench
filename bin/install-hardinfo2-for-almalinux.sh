#!/usr/bin/env bash
#
# install_hardinfo2_almalinux.sh
# Builds and installs HardInfo2 (https://github.com/hardinfo2/hardinfo2) on AlmaLinux
# Tested logic against AlmaLinux 8 / 9. Run as a normal user with sudo privileges
# (do NOT run this whole script as root; it will sudo internally where needed).
#
# Usage:
#   chmod +x install_hardinfo2_almalinux.sh
#   ./install_hardinfo2_almalinux.sh
#

set -euo pipefail
log()  { printf '\n\033[1;32m[+] %s\033[0m\n' "$1"; }
warn() { printf '\n\033[1;33m[!] %s\033[0m\n' "$1"; }
die()  { printf '\n\033[1;31m[x] %s\033[0m\n' "$1"; exit 1; }

if [[ $EUID -eq 0 ]]; then
  die "Please run this script as a regular (non-root) user with sudo rights, not as root."
fi
command -v sudo >/dev/null 2>&1 || die "sudo is required but not found. Install sudo first."
if [[ ! -f /etc/almalinux-release ]] && ! grep -qi almalinux /etc/os-release 2>/dev/null; then
  warn "This does not look like AlmaLinux. Continuing anyway, but the package names may not match."
fi

RELEASE_MAJOR="$(rpm -E %rhel 2>/dev/null || echo 9)"
log "Detected AlmaLinux major version: ${RELEASE_MAJOR}"
log "Enabling EPEL repository"
sudo dnf install -y epel-release

log "Enabling CRB (CodeReady Builder) repository (needed for libdecor-devel)"
if command -v dnf >/dev/null 2>&1 && dnf config-manager --help >/dev/null 2>&1; then
  sudo dnf config-manager --set-enabled crb || \
    sudo dnf config-manager --set-enabled "powertools" || \
    warn "Could not auto-enable CRB/PowerTools. Enable it manually if the build fails on libdecor-devel."
else
  sudo dnf install -y dnf-plugins-core
  sudo dnf config-manager --set-enabled crb || \
    sudo dnf config-manager --set-enabled "powertools" || \
    warn "Could not auto-enable CRB/PowerTools. Enable it manually if the build fails on libdecor-devel."
fi

log "Refreshing package metadata"
sudo dnf makecache

log "Installing build toolchain"
sudo dnf install -y git cmake gcc gcc-c++ gettext rpmdevtools curl

log "Installing HardInfo2 build dependencies"
sudo dnf install -y \
  json-glib-devel zlib-devel libsoup3-devel gtk3-devel qt5-qtbase-devel \
  libdecor-devel wayland-devel glslang

WORKDIR="${HOME}/hardinfo2-build"
if [[ -d "${WORKDIR}/hardinfo2" ]]; then
  log "Existing clone found at ${WORKDIR}/hardinfo2, pulling latest changes"
  git -C "${WORKDIR}/hardinfo2" fetch --all --tags
else
  log "Cloning HardInfo2 source"
  mkdir -p "${WORKDIR}"
  git clone https://github.com/hardinfo2/hardinfo2 "${WORKDIR}/hardinfo2"
fi
cd "${WORKDIR}/hardinfo2"

log "Switching to latest stable release tag"
chmod +x ./tools/git_latest_release.sh
./tools/git_latest_release.sh
log "Configuring build with CMake"
rm -rf build
mkdir -p build
cd build
cmake ..
log "Compiling and packaging (this creates an installable RPM)"
make package -j"$(nproc)"


log "Installing the freshly built HardInfo2 package"
PKG="$(ls hardinfo2-*.rpm 2>/dev/null | head -n1 || true)"
if [[ -z "${PKG}" ]]; then
  die "No hardinfo2-*.rpm package found after build. Check the build log above for errors."
fi

if rpm -q hardinfo2 >/dev/null 2>&1; then
  sudo dnf reinstall -y "./${PKG}"
else
  sudo dnf install -y "./${PKG}"
fi

log "Installing recommended runtime dependencies"
sudo dnf install -y \
  lm_sensors sysbench glx-utils dmidecode udisks2 xdg-utils \
  iperf3 fwupd xorg-x11-server-utils vulkan-tools gawk || \
  warn "Some optional runtime packages could not be installed. HardInfo2 will still run with reduced functionality."

log "Installation complete!"
echo "Run it with:  hardinfo2"
