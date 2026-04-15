{ config, pkgs, lib, inputs, ... }:

let
  ocPath = "/boot/EFI/OC";

  oceanixPkgs = import pkgs.path {
    inherit (pkgs) system config;
    overlays = [ inputs.oceanix.overlays.default ];
  };

  ocResources = pkgs.fetchzip {
    url = "https://github.com/acidanthera/OcBinaryData/archive/refs/heads/master.zip";
    sha256 = "sha256-B5CABp0Y2dAVuw7185suaUuryl3iII4QNBVBttivQ7Y=";
  };

  ocConfig = inputs.oceanix.lib.OpenCoreConfig {
    pkgs = oceanixPkgs;
    modules = [
      ({ ... }: {
        oceanix.opencore.settings = {
          UEFI.Output.ProvideConsoleGop = true;
          UEFI.Output.Resolution = "1366x768";
          UEFI.Output.TextRenderer = "BuiltinGraphics";

          UEFI.Audio = {
            AudioCodec = 0;
            AudioDevice = "PciRoot(0x0)/Pci(0x1b,0x0)";
            AudioOutMask = 1;
            AudioSupport = true;
            ResetTrafficClass = true;
            DisconnectHda = false;
            MaximumGain = -10;
            MinimumAssistGain = -30;
            MinimumAudibleGain = -128;
            PlayChime = "Enabled";
            SetupDelay = 0;
          };

          Misc.Boot.PickerMode = "External";
          Misc.Boot.PickerVariant = "Acidanthera\\Syrah";
          Misc.Boot.PickerAttributes = 17;
          Misc.Boot.Timeout = 15;
          Misc.Boot.HideAuxiliary = true;

          Misc.Debug = {
            AppleDebug = true;
            ApplePanic = true;
            DisableWatchDog = true;
            DisplayLevel = 2147483650;
            Target = 3;
          };

          Misc.Security.SecureBootModel = "Disabled";
          Misc.Security.ScanPolicy = 0;
          Misc.Security.Vault = "Optional";
          UEFI.Quirks.DisableSecurityPolicy = true;
          UEFI.Quirks.ReleaseUsbOwnership = true;

          PlatformInfo.Automatic = true;
          PlatformInfo.Generic = {
            SystemProductName = "MacBookPro9,2";
            SystemSerialNumber = "C02J19YCDTY3";
            SystemUUID = "8FF32D62-EC2E-46D1-A6D3-D1A5748F5F7B";
            MLB = "C02227802QXF1YJ1M";
          };

          UEFI.Drivers = {
            "OpenRuntime.efi" = { Enabled = true; };
            "OpenCanopy.efi" = { Enabled = true; };
            "OpenUsbKbDxe.efi" = { Enabled = true; };
            "OpenLinuxBoot.efi" = { Enabled = true; };
            "AudioDxe.efi" = { Enabled = true; };
          };
          Misc.Entries = [ ];
        };
      })
    ];
  };

in
{
  system.activationScripts.opencoreConfig = {
    text = ''
      echo "--- Kopurando In1t  ---"
      
      if [ ! -d "${ocPath}" ] || ! ${pkgs.diffutils}/bin/diff -r "${ocConfig.efiPackage}/EFI/OC" "${ocPath}" >/dev/null 2>&1; then
        echo "diffs are detected, writing EFI files..."
        
        rm -rf ${ocPath}
        mkdir -p ${ocPath}
        cp -rf ${ocConfig.efiPackage}/EFI/OC/* ${ocPath}/
        
        mkdir -p ${ocPath}/Resources
        cp -rf ${ocResources}/Resources/* ${ocPath}/Resources/
      else
        echo "EFI is already up to date."
      fi
      
      if ! ${pkgs.efibootmgr}/bin/efibootmgr | grep -q "OpenCore_Copland"; then
        ${pkgs.efibootmgr}/bin/efibootmgr -c -d /dev/sda -p 1 -L "OpenCore_Copland" -l "\EFI\OC\OpenCore.efi"
      fi
    '';
  };
}
