#!/usr/bin/env bash
set -e

echo "==> Installing Fastfetch..."
dnf install -y fastfetch

echo "==> Deploying Fastfetch configuration..."
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TARGET_USER="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$TARGET_USER")

mkdir -p "$USER_HOME/.config/fastfetch"
cp "$ROOT_DIR/config/fastfetch/config.jsonc" "$USER_HOME/.config/fastfetch/config.jsonc"
chown -R "$TARGET_USER:$TARGET_USER" "$USER_HOME/.config/fastfetch"

