#!/usr/bin/env bash
set -e

[[ $EUID -ne 0 ]] && echo "Run with sudo" && exit 1

# ── CPU ──────────────────────────────────────────────────────────────────────
VENDOR=$(grep -m1 'vendor_id' /proc/cpuinfo | awk '{print $3}')
if [[ "$VENDOR" == "AuthenticAMD" ]]; then
  CPU_MICROCODE="hardware.cpu.amd.updateMicrocode"
  CPU_KVM="kvm-amd"
else
  CPU_MICROCODE="hardware.cpu.intel.updateMicrocode"
  CPU_KVM="kvm-intel"
fi

# ── GPU ──────────────────────────────────────────────────────────────────────
HAS_AMD=false
HAS_NVIDIA=false
lspci | grep -qi 'amd\|radeon' && HAS_AMD=true
lspci | grep -qi 'nvidia'      && HAS_NVIDIA=true

if $HAS_AMD && $HAS_NVIDIA; then
  GPU_DRIVER="hybrid-amd-nvidia"
elif $HAS_AMD; then
  GPU_DRIVER="amd"
elif $HAS_NVIDIA; then
  GPU_DRIVER="nvidia"
else
  GPU_DRIVER="intel"
fi

echo "CPU: $VENDOR → $CPU_KVM"
echo "GPU: $GPU_DRIVER"
echo ""

INITRD_MODULES=""
if [[ "$GPU_DRIVER" == "hybrid-amd-nvidia" ]]; then
  INITRD_MODULES="\"amdgpu\" \"nvidia\" \"nvidia_modeset\" \"nvidia_uvm\" \"nvidia_drm\""
elif [[ "$GPU_DRIVER" == "intel" ]]; then
  INITRD_MODULES="\"i915\""
elif [[ "$GPU_DRIVER" == "amd" ]]; then
  INITRD_MODULES="\"amdgpu\""
elif [[ "$GPU_DRIVER" == "nvidia" ]]; then
  INITRD_MODULES="\"nvidia\" \"nvidia_modeset\" \"nvidia_uvm\" \"nvidia_drm\""
fi

# ── Disks ────────────────────────────────────────────────────────────────────
lsblk -o NAME,SIZE,FSTYPE,UUID,MOUNTPOINT
echo ""

read -rp "Root partition (e.g. /dev/sda2): " ROOT_PART
[[ ! -b "$ROOT_PART" ]] && echo "Invalid partition" && exit 1
ROOT_UUID=$(blkid -s UUID -o value "$ROOT_PART")
ROOT_FSTYPE=$(blkid -s TYPE -o value "$ROOT_PART")
echo "Root → $ROOT_UUID ($ROOT_FSTYPE)"

read -rp "Boot/EFI partition (e.g. /dev/sda1): " BOOT_PART
[[ ! -b "$BOOT_PART" ]] && echo "Invalid partition" && exit 1
BOOT_UUID=$(blkid -s UUID -o value "$BOOT_PART")
echo "Boot → $BOOT_UUID"

EXTRA_BLOCK=""
read -rp "Extra partition? (leave empty to skip): " EXTRA_PART
if [[ -n "$EXTRA_PART" ]]; then
  EXTRA_UUID=$(blkid -s UUID -o value "$EXTRA_PART")
  EXTRA_FSTYPE=$(blkid -s TYPE -o value "$EXTRA_PART")
  read -rp "Mount point (e.g. /mnt/hdd): " EXTRA_MOUNT
  EXTRA_BLOCK="
  fileSystems.\"$EXTRA_MOUNT\" = {
    device = \"/dev/disk/by-uuid/$EXTRA_UUID\";
    fsType = \"$EXTRA_FSTYPE\";
    options = [ \"defaults\" \"nofail\" ];
  };
"
fi

# ── Write hardware.nix ───────────────────────────────────────────────────────
cat > ./hardware.nix <<EOF
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ $INITRD_MODULES ];
  boot.kernelModules = [ "$CPU_KVM" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/$ROOT_UUID";
    fsType = "$ROOT_FSTYPE";
  };
$EXTRA_BLOCK
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/$BOOT_UUID";
    fsType = "vfat";
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  $CPU_MICROCODE = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
EOF

# ── Update machine.nix ───────────────────────────────────────────────────────
if grep -q 'elars.hardware.graphics.driver' ./machine.nix; then
  sed -i "s|elars.hardware.graphics.driver = .*|elars.hardware.graphics.driver = \"$GPU_DRIVER\";|" ./machine.nix
  echo "Updated driver in machine.nix → $GPU_DRIVER"
else
  echo ""
  echo "Add this line to machine.nix:"
  echo "  elars.hardware.graphics.driver = \"$GPU_DRIVER\";"
fi

echo ""
echo "Done. hardware.nix generated."
[[ "$GPU_DRIVER" == "hybrid-amd-nvidia" ]] && \
  echo "PRIME bus IDs needed — run: lspci | grep -E 'VGA|3D'"
