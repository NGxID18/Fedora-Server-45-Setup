#!/usr/bin/env bash
set -e

echo "==> Installing Zsh and plugins..."
dnf install -y \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting

echo "==> Deploying .zshrc..."
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TARGET_USER="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$TARGET_USER")

cp "$ROOT_DIR/config/shell/.zshrc" "$USER_HOME/.zshrc"
chown "$TARGET_USER:$TARGET_USER" "$USER_HOME/.zshrc"

echo "==> Changing default shell to Zsh..."
chsh -s "$(which zsh)" "$TARGET_USER"

echo "==> Applying Zsh..."
exec zsh -l
