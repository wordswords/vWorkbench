#!/usr/bin/env bash

ELIXIR_VERSION="1.19.5"
OTP_MAJOR="$(erl -noshell -eval 'io:format("~s~n", [erlang:system_info(otp_release)]), halt().')"

sudo mkdir -p /opt/elixir
cd /tmp

curl -fL -o elixir.zip \
  "https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/elixir-otp-${OTP_MAJOR}.zip"

sudo unzip -q elixir.zip -d /opt/elixir
sudo ln -sf /opt/elixir/bin/elixir /usr/local/bin/elixir
sudo ln -sf /opt/elixir/bin/elixirc /usr/local/bin/elixirc
sudo ln -sf /opt/elixir/bin/iex /usr/local/bin/iex
sudo ln -sf /opt/elixir/bin/mix /usr/local/bin/mix

