{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v2;
  
  boot.kernelParams = [
     "preempt=full"
     "i915.enable_guc=2"
     "i915.fastboot=1"
     "mitigations=off"      
     "usbcore.autosuspend=-1"
  ];
  
  boot.loader = {
    timeout = 5; 
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    systemd-boot = {
      enable = true;
      configurationLimit = 15; 
      consoleMode = "max";     
      editor = false;          
    };
  };
}