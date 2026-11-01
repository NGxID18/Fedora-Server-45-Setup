#!/usr/bin/env bash
set -e

echo "==> Installing NVIDIA driver..."
dnf install -y \
    akmod-nvidia \
    xorg-x11-drv-nvidia-cuda \
    nvidia-persistenced

echo "==> Enabling persistence daemon..."
systemctl enable nvidia-persistenced.service

echo "==> Building kernel module and initramfs..."
akmods --force
dracut --force
