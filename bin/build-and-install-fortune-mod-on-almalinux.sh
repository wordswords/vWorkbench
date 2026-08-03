#!/usr/bin/env bash
set -euo pipefail

REPO_URL="git@github.com:wordswords/fortune-mod-almalinux-dpc.git"
PREFIX="/usr/local"
BUILD_DIR="${HOME}/src/fortune-mod-build"
SRC_DIR="${BUILD_DIR}/fortune-mod/"

sudo rm -rf "$BUILD_DIR"
mkdir -p "${BUILD_DIR}"

need_root() {
  if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
    if command -v sudo >/dev/null 2>&1; then
      sudo "$@"
    else
      echo "This step needs root. Re-run as root or install sudo." >&2
      exit 1
    fi
  else
    "$@"
  fi
}

pkg_install() {
  need_root dnf install -y "$@"
}

echo "==> Installing build dependencies"
need_root dnf groupinstall -y "Development Tools"
pkg_install \
  cmake \
  git \
  gcc \
  gcc-c++ \
  make \
  pkgconf-pkg-config \
  recode \
  recode-devel \
  perl \
  perl-interpreter \
  perl-Path-Tiny \
  perl-File-Find-Object \
  perl-Getopt-Long \
  perl-Test-Harness \
  perl-Test-Trap \
  perl-Test-Differences \
  perl-autodie \
  chrpath \
  perl-App-cpanminus

echo "==> Installing App::Docmake via CPAN"
if ! need_root cpanm App::Docmake 2>/dev/null; then
  echo "Warning: Failed to install App::Docmake via cpanm. Trying with cpan..."
  if ! need_root cpan App::Docmake 2>/dev/null; then
    echo "Warning: Could not install App::Docmake. Man page generation may fail."
    echo "The build will continue without man pages."
  fi
fi

cd "${BUILD_DIR}"

if [[ ! -d "${SRC_DIR}" ]]; then
  echo "==> Cloning source"
  git clone "${REPO_URL}" "${SRC_DIR}"
else
  echo "==> Updating existing source tree"
  git -C "${SRC_DIR}" pull --ff-only
fi

# Use a separate build directory to avoid conflicts with source directories
BUILD_DIR_CMAKE="${BUILD_DIR}/cmake-build"
mkdir -p "${BUILD_DIR_CMAKE}"

echo "==> Configuring build"
# Use -S and -B to specify source and build directories explicitly
cmake -S "${SRC_DIR}/fortune-mod" -B "${BUILD_DIR_CMAKE}" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DCOOKIEDIR="${PREFIX}/share/fortune" \
  -DLOCALDIR="${PREFIX}/share/fortune" \
  -DNO_OFFENSIVE=TRUE

echo "==> Building"
# Check if docmake is available; if not, configure without man pages
if ! command -v docmake >/dev/null 2>&1; then
  echo "docmake not found; configuring build without man pages"
  cmake -S "${SRC_DIR}/fortune-mod" -B "${BUILD_DIR_CMAKE}" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCOOKIEDIR="${PREFIX}/share/fortune" \
    -DLOCALDIR="${PREFIX}/share/fortune" \
    -DNO_OFFENSIVE=TRUE \
    -DBUILD_MAN_PAGES=OFF
  cmake --build "${BUILD_DIR_CMAKE}" -j"$(nproc)"
else
  # Try building with man pages first
  if ! cmake --build "${BUILD_DIR_CMAKE}" -j"$(nproc)"; then
    echo "Build failed. Trying to disable man page generation..."
    cmake -S "${SRC_DIR}/fortune-mod" -B "${BUILD_DIR_CMAKE}" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
      -DCOOKIEDIR="${PREFIX}/share/fortune" \
      -DLOCALDIR="${PREFIX}/share/fortune" \
      -DNO_OFFENSIVE=TRUE \
      -DBUILD_MAN_PAGES=OFF
    cmake --build "${BUILD_DIR_CMAKE}" -j"$(nproc)"
  fi
fi

echo "==> Running tests if available"
if cmake --build "${BUILD_DIR_CMAKE}" --target check -- -q >/dev/null 2>&1; then
  cmake --build "${BUILD_DIR_CMAKE}" --target check || true
else
  echo "No 'check' target detected; skipping tests"
fi

echo "==> Installing"
need_root cmake --install "${BUILD_DIR_CMAKE}"
need_root ldconfig || true

echo "==> Looking for installed binaries"
FOUND_STRFILE="$(command -v strfile || true)"
FOUND_FORTUNE="$(command -v fortune || true)"

if [[ -z "${FOUND_STRFILE}" && -x "${PREFIX}/bin/strfile" ]]; then
  FOUND_STRFILE="${PREFIX}/bin/strfile"
fi
if [[ -z "${FOUND_STRFILE}" && -x "${PREFIX}/games/strfile" ]]; then
  FOUND_STRFILE="${PREFIX}/games/strfile"
fi
if [[ -z "${FOUND_FORTUNE}" && -x "${PREFIX}/bin/fortune" ]]; then
  FOUND_FORTUNE="${PREFIX}/bin/fortune"
fi
if [[ -z "${FOUND_FORTUNE}" && -x "${PREFIX}/games/fortune" ]]; then
  FOUND_FORTUNE="${PREFIX}/games/fortune"
fi

echo
if [[ -n "${FOUND_STRFILE}" ]]; then
  echo "strfile installed at: ${FOUND_STRFILE}"
  "${FOUND_STRFILE}" -h || true
else
  echo "strfile was not found on PATH; search with: find ${PREFIX} /usr -name strfile 2>/dev/null"
fi

echo
if [[ -n "${FOUND_FORTUNE}" ]]; then
  echo "fortune installed at: ${FOUND_FORTUNE}"
  "${FOUND_FORTUNE}" -v || true
else
  echo "fortune was not found on PATH. If installed under ${PREFIX}/games, add it to PATH:"
  echo 'export PATH="/usr/local/bin:/usr/local/games:$PATH"'
fi
