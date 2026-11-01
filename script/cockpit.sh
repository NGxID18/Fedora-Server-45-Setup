#!/usr/bin/env bash
set -e

echo "==> Installing Cockpit and modules..."
dnf install -y \
    cockpit \
    cockpit-files \
    cockpit-podman \
    cockpit-machines

echo "==> Enabling Cockpit socket..."
systemctl enable --now cockpit.socket
