#!/usr/bin/env bash
set -e

echo "==> Installing minimal GNOME desktop..."
dnf install -y \
    gdm \
    gnome-shell \
    nautilus \
    gnome-text-editor \
    gnome-calculator \
    gnome-software \
    gnome-tweaks \
    gnome-extensions-app

echo "==> Setting default boot target to graphical interface..."
systemctl set-default graphical.target

echo "==> Installing GNOME extensions from extensions.gnome.org..."
TARGET_USER="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$TARGET_USER")
SHELL_VER=$(gnome-shell --version | awk '{print $3}' | cut -d. -f1)

EXTENSIONS=(
    "blur-my-shell@aunetx"
    "Vitals@CoreCoding.com"
    "appindicatorsupport@rgcjonas.gmail.com"
)

for uuid in "${EXTENSIONS[@]}"; do
    echo "  -> Installing $uuid..."
    INFO_URL="https://extensions.gnome.org/extension-info/?uuid=${uuid}&shell_version=${SHELL_VER}"
    DL_PATH=$(curl -s -H "User-Agent: Mozilla/5.0" "$INFO_URL" | grep -oP '(?<="download_url": ")[^"]+' || true)

    if [ -n "$DL_PATH" ]; then
        TMP_ZIP="/tmp/${uuid}.zip"
        curl -sL -H "User-Agent: Mozilla/5.0" "https://extensions.gnome.org${DL_PATH}" -o "$TMP_ZIP"
        
        if [ -n "${SUDO_USER:-}" ]; then
            sudo -u "$TARGET_USER" gnome-extensions install --force "$TMP_ZIP"
            sudo -u "$TARGET_USER" gnome-extensions enable "$uuid" 2>/dev/null || true
        else
            gnome-extensions install --force "$TMP_ZIP"
            gnome-extensions enable "$uuid" 2>/dev/null || true
        fi
        rm -f "$TMP_ZIP"
    else
        echo "     Warning: Could not fetch download URL for $uuid"
    fi
done
