#!/usr/bin/env bash
set -e

echo "==> Installing Kitty terminal..."
dnf install -y kitty

echo "==> Deploying Kitty configuration..."
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TARGET_USER="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$TARGET_USER")

mkdir -p "$USER_HOME/.config/kitty"
cp -r "$ROOT_DIR/config/kitty/." "$USER_HOME/.config/kitty/"
chown -R "$TARGET_USER:$TARGET_USER" "$USER_HOME/.config/kitty"

