#!/usr/bin/env bash

sudo dnf install -y curl tar

VER=$(curl -fsSL https://api.github.com/repos/dandavison/delta/releases/latest \
  | grep -Po '"tag_name":\s*"\K[^"]+')

cd /tmp
curl -fL -O \
  "https://github.com/dandavison/delta/releases/download/${VER}/delta-${VER}-x86_64-unknown-linux-gnu.tar.gz"

tar -xzf "delta-${VER}-x86_64-unknown-linux-gnu.tar.gz"
sudo install -m 0755 "delta-${VER}-x86_64-unknown-linux-gnu/delta" /usr/local/bin/delta


