{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.oceanix.nixosModules.default ]; #

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v2; #

  boot.kernelParams = [
    "preempt=full"
    "i915.enable_fbc=1"
    "i915.fastboot=1"
    "mitigations=off"
    "usbcore.autosuspend=-1"
    "transparent_hugepage=always"
  ]; #

  boot.loader = {
    timeout = 5;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    }; #
    systemd-boot = {
      enable = true;
      configurationLimit = 15;
      consoleMode = "max";
      editor = false;
    }; #
  };
  oceanix = {
    enable = true;

    entries = {
      "NixOS (systemd-boot)" = {
        path = "/EFI/systemd/systemd-bootx64.efi";
      };
      "NixOS (Limine)" = {
        path = "/EFI/limine/BOOTX64.EFI";
      };
    };
    uefi = {
      output = {
        provideConsoleGop = true;
        directGopRendering = true;
        resolution = "1366x768";
        ignoreTextInGraphics = true;
      };

      quirks = {
        releaseUsbOwnership = true;
        requestBootVarRouting = true;
      };
    };

    misc.boot = {
      showPicker = true;
      timeout = 5;
    };
  };
}
