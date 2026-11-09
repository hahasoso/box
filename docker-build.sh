#!/bin/bash
# Build the ISO inside a Debian 12 container (works on Linux, macOS, Windows+Docker Desktop via Git Bash/WSL).
set -e
cd "$(dirname "$0")"
docker run --rm --privileged -v "$PWD":/build -w /build debian:bookworm bash -c \
 "apt-get update && apt-get install -y live-build debootstrap squashfs-tools xorriso syslinux syslinux-common isolinux grub-pc-bin grub-efi-amd64-bin mtools dosfstools ca-certificates && ./build.sh"
