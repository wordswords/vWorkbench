#!/usr/bin/env bash
# Install a prebuilt Elixir release for a given Erlang/OTP install.
#
# Erlang/OTP is installed to a versioned prefix (e.g. /opt/erlang/29.0.5) by
# install-erlang-almalinux.sh. The `erl` binary is only added to PATH via a
# login-shell profile.d snippet, which is NOT active in this non-login shell,
# so we must locate it explicitly rather than assume it is on PATH.

set -euo pipefail

# ELIXIR_VERSION can be set via the environment (exported by deploy.sh) or as
# the first positional argument; it defaults to the latest release channel.
ELIXIR_VERSION="${ELIXIR_VERSION:-${1:-1.20-latest}}"
OTP_PREFIX="${OTP_PREFIX:-}"          # optional override
ERL_BIN="${ERL_BIN:-}"

# Locate the most recent Erlang/OTP install if not explicitly provided.
if [[ -z "${ERL_BIN}" ]]; then
    # Prefer the newest versioned prefix under /opt/erlang.
    if [[ -d /opt/erlang ]]; then
        latest="$(find /opt/erlang -mindepth 1 -maxdepth 1 -type d -printf '%f\n' \
            | sort -V | tail -n 1)"
        if [[ -n "${latest}" && -x "/opt/erlang/${latest}/bin/erl" ]]; then
            ERL_BIN="/opt/erlang/${latest}/bin/erl"
            OTP_PREFIX="/opt/erlang/${latest}"
        fi
    fi
fi

# Fall back to PATH, then to common locations.
if [[ -z "${ERL_BIN}" ]]; then
    if command -v erl >/dev/null 2>&1; then
        ERL_BIN="$(command -v erl)"
    elif [[ -x /usr/local/bin/erl ]]; then
        ERL_BIN="/usr/local/bin/erl"
    else
        echo "Error: could not locate the 'erl' binary. Run install-erlang-almalinux.sh first." >&2
        exit 1
    fi
fi

echo "Using Erlang at: ${ERL_BIN}"

OTP_MAJOR="$("${ERL_BIN}" -noshell -eval 'io:format("~s~n", [erlang:system_info(otp_release)]), halt().')"
if [[ -z "${OTP_MAJOR}" ]]; then
    echo "Error: unable to determine the OTP release from ${ERL_BIN}" >&2
    exit 1
fi

sudo mkdir -p /opt/elixir

# Download to a scratch dir and clean up after ourselves.
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT
cd "${TMP_DIR}"

echo "Downloading https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/elixir-otp-${OTP_MAJOR}.zip"
curl -fL -o elixir.zip \
    "https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/elixir-otp-${OTP_MAJOR}.zip"

sudo unzip -q elixir.zip -d /opt/elixir

sudo ln -sf /opt/elixir/bin/elixir  /usr/local/bin/elixir
sudo ln -sf /opt/elixir/bin/elixirc /usr/local/bin/elixirc
sudo ln -sf /opt/elixir/bin/iex     /usr/local/bin/iex
sudo ln -sf /opt/elixir/bin/mix     /usr/local/bin/mix

echo "Elixir ${ELIXIR_VERSION} installed (built against OTP ${OTP_MAJOR})."
