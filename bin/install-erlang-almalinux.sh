#!/usr/bin/env bash
# Build and install Erlang/OTP from source on AlmaLinux 10.
# Usage: sudo ./install_erlang_almalinux10.sh [OTP_VERSION] [INSTALL_PREFIX]
# Example: sudo ./install_erlang_almalinux10.sh 29.0.5 /opt/erlang/29.0.5

set -Eeuo pipefail

OTP_VERSION="${1:-29.0.5}"
PREFIX="${2:-/opt/erlang/${OTP_VERSION}}"
ARCHIVE="otp_src_${OTP_VERSION}.tar.gz"
SOURCE_DIR="otp_src_${OTP_VERSION}"
DOWNLOAD_URL="https://github.com/erlang/otp/releases/download/OTP-${OTP_VERSION}/${ARCHIVE}"
BUILD_ROOT="$(mktemp -d)"

cleanup() {
  rm -rf "${BUILD_ROOT}"
}
trap cleanup EXIT

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run this script as root, for example: sudo $0 [OTP_VERSION] [INSTALL_PREFIX]" >&2
  exit 1
fi

if [[ ! -f /etc/almalinux-release ]]; then
  echo "Warning: this script is intended for AlmaLinux." >&2
fi

if ! command -v dnf >/dev/null 2>&1; then
  echo "Error: dnf was not found. AlmaLinux 10 is required." >&2
  exit 1
fi

echo "Installing build dependencies..."
dnf -y install \
  gcc gcc-c++ make perl \
  ncurses-devel openssl-devel \
  wget tar gzip findutils

echo "Downloading Erlang/OTP ${OTP_VERSION}..."
cd "${BUILD_ROOT}"
wget --https-only --progress=dot:giga -O "${ARCHIVE}" "${DOWNLOAD_URL}"

echo "Extracting source..."
tar -xzf "${ARCHIVE}"
cd "${SOURCE_DIR}"

echo "Configuring Erlang/OTP for ${PREFIX}..."
./configure \
  --prefix="${PREFIX}" \
  --enable-jit \
  --enable-dirty-schedulers \
  --disable-jinterface \
  --without-odbc \
  --without-wx

echo "Building Erlang/OTP..."
make -j"$(nproc)"

echo "Installing Erlang/OTP..."
make install

PROFILE_FILE="/etc/profile.d/erlang-${OTP_VERSION}.sh"
cat > "${PROFILE_FILE}" <<EOF
# Erlang/OTP ${OTP_VERSION}
export PATH="${PREFIX}/bin:\$PATH"
EOF
chmod 0644 "${PROFILE_FILE}"

ln -sfn "${PREFIX}/bin/erl" /usr/local/bin/erl
ln -sfn "${PREFIX}/bin/escript" /usr/local/bin/escript
ln -sfn "${PREFIX}/bin/erlc" /usr/local/bin/erlc

echo
echo "Erlang/OTP ${OTP_VERSION} installed successfully."
echo "Install prefix: ${PREFIX}"
echo "Verify with: ${PREFIX}/bin/erl -version"
echo "Open a new shell, or run: source ${PROFILE_FILE}"
"${PREFIX}/bin/erl" -noshell -eval 'io:format("OTP release: ~s~n", [erlang:system_info(otp_release)]), halt().' 

