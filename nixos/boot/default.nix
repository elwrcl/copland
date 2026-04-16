{ pkgs, ... }:

{
  imports = [
    ./opencore.nix
  ];

  environment.systemPackages = [ pkgs.efibootmgr ];

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v2;

  boot.kernelParams = [
    "preempt=full"
    "i915.enable_fbc=1"
    "mitigations=off"
    "usbcore.autosuspend=-1"
    "transparent_hugepage=always"
  ];

  boot.loader = {
    timeout = 2;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
  };
}
