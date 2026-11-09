# Turn this BoxOS 0.3.0 source into a bootable ISO

This archive contains **Debian 12 live-build configuration**, not a prebuilt operating-system image. It aims to produce `BoxOS-0.3.0.iso` (Debian-based, IceWM desktop, Firefox ESR). An internet connection and Debian package downloads are required. **The ISO has not been built or boot-verified in the assistant environment.**

## Option A — GitHub Actions (no Linux install on your computer)

1. Create a new GitHub repository (e.g. `boxos-iso-builder`).
2. Upload **all contents of this `boxos-build` folder to the repository root**, including the hidden `.github` directory; keep `build.sh` and `config/` at the root.
3. Open **Actions → Build BoxOS 0.3.0 ISO → Run workflow → Run workflow**. The workflow also starts automatically on a push to `main`.
4. After the workflow finishes successfully, open the run and download the `BoxOS-0.3.0-ISO` artifact.
5. Extract the artifact ZIP to obtain **`BoxOS-0.3.0.iso`** and its SHA-256 checksum. Attach that `.iso` under VirtualBox **Settings → Storage → Optical Drive**.

If the workflow fails, open its build log. A failure does **not** indicate a working ISO was produced; fix the specific package/build error and retry.

## Option B — Docker Desktop (Windows/macOS/Linux)

Install Docker Desktop and make sure it is running. Open a terminal inside `boxos-build` and run:

```bash
bash docker-build.sh
```

The result, **if the build succeeds**, is `BoxOS-0.3.0.iso` in the same directory. Docker requires internet access and sufficient free disk space (10+ GiB recommended).

## Option C — Debian 12 amd64

```bash
sudo apt-get update
sudo apt-get install -y live-build debootstrap squashfs-tools xorriso syslinux syslinux-common isolinux grub-pc-bin grub-efi-amd64-bin mtools dosfstools ca-certificates
sudo bash build.sh
```

## VirtualBox configuration

- Guest type: **Linux / Debian (64-bit)**, not Other/Unknown.
- RAM: 2–4 GiB; 2 virtual CPUs; graphics controller: VMSVGA; video memory: 64–128 MiB.
- Optical drive: generated **`BoxOS-0.3.0.iso`**.
- Network: NAT. Default BIOS boot is a good first test.
- This build is a **live system**, not an installer. Files are not persistent across reboots unless extra persistence is configured.

**Important architecture note:** Unlike earlier original-kernel BOXOS 0.2.0 prototypes, this particular uploaded 0.3.0 project is a **Debian-based** live OS with IceWM and Firefox ESR. It can run Debian-compatible Linux applications using their standard packages. That is not equivalent to native support for arbitrary Windows or macOS applications.
