#!/usr/bin/env bash
set -Eeuo pipefail

VENV_DIR="${HOME}/aider-venv"
PYTHON_BIN="${PYTHON_BIN:-python3}"
AIDER_PKG="aider-chat[playwright]"

log() {
  printf '\n[%s] %s\n' "$(date '+%F %T')" "$*"
}

require_root_sudo() {
  if ! command -v sudo >/dev/null 2>&1; then
    echo "Error: sudo is required but not installed."
    exit 1
  fi
}

detect_pkg_manager() {
  if command -v dnf >/dev/null 2>&1; then
    PKG_MGR="dnf"
  elif command -v yum >/dev/null 2>&1; then
    PKG_MGR="yum"
  else
    echo "Error: neither dnf nor yum was found."
    exit 1
  fi
}

install_system_packages() {
  log "Installing system packages"
  sudo "${PKG_MGR}" install -y \
    python3 \
    python3-pip \
    python3-virtualenv \
    git \
    curl \
    ca-certificates \
    nss \
    nspr \
    atk \
    at-spi2-atk \
    at-spi2-core \
    cups-libs \
    libdrm \
    libXcomposite \
    libXdamage \
    libXext \
    libXfixes \
    libXrandr \
    libxkbcommon \
    mesa-libgbm \
    pango \
    alsa-lib \
    gtk3 \
    xorg-x11-fonts-Type1 \
    xorg-x11-xauth \
    libatomic
}

create_venv() {
  log "Creating virtual environment at ${VENV_DIR}"
  "${PYTHON_BIN}" -m venv "${VENV_DIR}"
  # shellcheck disable=SC1090
  source "${VENV_DIR}/bin/activate"
}

upgrade_packaging_tools() {
  log "Upgrading pip/setuptools/wheel"
  python -m pip install --upgrade pip setuptools wheel
}

install_aider_and_playwright() {
  log "Installing Aider with Playwright support"
  python -m pip install --upgrade "${AIDER_PKG}"
}

install_browser() {
  log "Installing Playwright Chromium and dependencies"
  python -m playwright install --with-deps chromium
}

verify_install() {
  log "Verifying installation"

  echo "Python: $(command -v python)"
  echo "Pip:    $(command -v pip)"
  echo "Aider:  $(command -v aider || true)"

  python --version
  pip --version
  python -m playwright --version
  aider --version || true

  log "Testing Playwright import"
  python - <<'PY'
from playwright.sync_api import sync_playwright
print("Playwright Python import OK")
with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    page = browser.new_page()
    page.set_content("<title>ok</title><h1>Hello</h1>")
    print("Chromium launch OK")
    browser.close()
PY
}

print_next_steps() {
  cat <<EOF

Installation complete.

To use Aider in this environment later, run:
  source "${VENV_DIR}/bin/activate"
  aider

If Aider ever says Playwright is missing, make sure you launched Aider from:
  ${VENV_DIR}

EOF
}

main() {
  require_root_sudo
  detect_pkg_manager
  install_system_packages
  create_venv
  upgrade_packaging_tools
  install_aider_and_playwright
  install_browser
  verify_install
  print_next_steps
}

main "$@"
