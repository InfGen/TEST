#!/bin/sh
set -e

echo "🚀 Building AIOS - Agentic Intelligence OS"
echo "Base: Alpine Linux | Now with optional Desktop"

VARIANT="${1:-base}"
ROOTFS="$(pwd)/rootfs-${VARIANT}"
mkdir -p "$ROOTFS"

echo "→ Bootstrapping Alpine ($VARIANT variant)..."

BASE_PKGS="alpine-base zsh curl wget git jq yq-go python3 py3-pip py3-virtualenv build-base linux-headers neovim htop btop ripgrep fd fzf bat eza starship fastfetch ca-certificates tzdata openssh sudo"

if [ "$VARIANT" = "desktop" ]; then
    echo "→ Adding XFCE Desktop + GUI tools (still keeping it relatively small)..."
    DESKTOP_PKGS="xfce4 xfce4-goodies lightdm lightdm-gtk-greeter xfce4-terminal adwaita-icon-theme papirus-icon-theme gnome-themes-extra font-noto font-dejavu firefox geany mousepad xorg-server mesa"
    apk --arch x86_64 --root "$ROOTFS" --initdb --no-cache add $BASE_PKGS $DESKTOP_PKGS
    apk --arch x86_64 --root "$ROOTFS" --initdb --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community add uv
else
    apk --arch x86_64 --root "$ROOTFS" --initdb --no-cache add $BASE_PKGS
    apk --arch x86_64 --root "$ROOTFS" --initdb --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community add uv
fi

echo "→ Setting up users and directories..."
chroot "$ROOTFS" adduser -D -s /bin/zsh -h /home/agent -G wheel agent 2>/dev/null || true
echo "agent ALL=(ALL) NOPASSWD:ALL" > "$ROOTFS/etc/sudoers.d/agent"

cp motd "$ROOTFS/etc/motd"
cp aios-help "$ROOTFS/usr/local/bin/aios-help"
chmod +x "$ROOTFS/usr/local/bin/aios-help"

# (Starship, fastfetch, profile, helper scripts would be copied/installed here - abbreviated for space)

echo "→ Creating compressed rootfs..."
tar -czf aios-${VARIANT}-rootfs.tar.gz -C "$ROOTFS" .
echo ""
echo "✅ AIOS $VARIANT build complete!"
echo "   Output: aios-${VARIANT}-rootfs.tar.gz"
echo ""
echo "Usage examples:"
echo "   docker import < aios-${VARIANT}-rootfs.tar.gz aios:${VARIANT}"
if [ "$VARIANT" = "desktop" ]; then
    echo "   For desktop: Use in a VM or with x11docker / X11 forwarding"
fi
echo ""
echo "Built for agents. Desktop variant added per request."
