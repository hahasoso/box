#!/bin/bash
# BoxOS ISO builder. Run as root on Debian 12 (or use docker-build.sh).
set -e
cd "$(dirname "$0")"
[ "$(id -u)" = 0 ] || { echo "Run as root: sudo ./build.sh"; exit 1; }
lb clean 2>/dev/null || true
lb config \
  --distribution bookworm \
  --architectures amd64 \
  --archive-areas "main contrib non-free-firmware" \
  --binary-images iso-hybrid \
  --bootloaders "syslinux,grub-efi" \
  --debian-installer none \
  --apt-recommends false \
  --memtest none \
  --iso-application "BoxOS" \
  --iso-volume "BOXOS_0_3" \
  --iso-publisher "BoxOS" \
  --bootappend-live "boot=live components quiet username=box hostname=boxos locales=en_US.UTF-8 keyboard-layouts=us"
lb build
mv -f live-image-amd64.hybrid.iso BoxOS-0.3.0.iso
sha256sum BoxOS-0.3.0.iso | tee BoxOS-0.3.0.iso.sha256
echo "Done: $(pwd)/BoxOS-0.3.0.iso"
