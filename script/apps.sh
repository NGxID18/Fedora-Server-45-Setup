#!/usr/bin/env bash
set -e

if [ ! -f /etc/yum.repos.d/vscodium.repo ]; then
    echo "==> Adding VSCodium repo..."
    rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
    tee /etc/yum.repos.d/vscodium.repo > /dev/null << 'EOF'
[gitlab.com_paulcarroty_vscodium_repo]
name=gitlab.com_paulcarroty_vscodium_repo
baseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
metadata_expire=1h
EOF
fi

echo "==> Installing native apps..."
dnf install -y \
    flatseal \
    codium \
    tuned

echo "==> Installing Flatpak apps..."
flatpak install -y flathub \
    com.valvesoftware.Steam \
    com.discordapp.Discord \
    io.gitlab.librewolf-community \
    org.prismlauncher.PrismLauncher \
    com.rtosta.zapzap \
    com.obsproject.Studio \
    org.freedesktop.Platform.VulkanLayer.OBSVkCapture
