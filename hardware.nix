{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ebf71dbc-969e-4613-9117-78b4c62e7216";
    fsType = "ext4";
  };

  fileSystems."/mnt/HDD" = {
    device = "/dev/disk/by-uuid/a9d12042-6501-4725-84bd-6e0bdbb64427";
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/72CC-9AE7";
    fsType = "vfat";
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
