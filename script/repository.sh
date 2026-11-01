#!/usr/bin/env bash
set -e

echo "==> Enabling RPM Fusion..."
dnf install -y \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

echo "==> Configuring Flatpak and Flathub..."
dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "==> Cleaning cache and updating system..."
dnf clean all
dnf upgrade --refresh -y

echo "==> Installing essential tools..."
dnf install -y \
    git \
    curl \
    wget

echo "==> Installing essential tools..."
dnf install -y \
    git \
    curl \
    wget
