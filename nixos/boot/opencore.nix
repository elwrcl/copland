{ config, pkgs, lib, inputs, ... }:

let
  ocPath = "/boot/EFI/OC";
  liminePath = "/boot/EFI/limine";

  ocPkg = pkgs.fetchzip {
    url = "https://github.com/acidanthera/OpenCorePkg/releases/download/1.0.1/OpenCore-1.0.1-RELEASE.zip";
    sha256 = "sha256-uKn0HlXQLDgZaYjRL3QcoqZ3iji0klz4pxYoLphP5rs=";
    stripRoot = false;
  };

  ocResources = pkgs.fetchzip {
    url = "https://github.com/acidanthera/OcBinaryData/archive/refs/heads/master.zip";
    sha256 = "sha256-B5CABp0Y2dAVuw7185suaUuryl3iII4QNBVBttivQ7Y=";
  };

  ocConfig = inputs.oceanix.lib.OpenCoreConfig {
    inherit pkgs;
    modules = [
      ({ ... }: {
        oceanix = {
          UEFI.Output.ProvideConsoleGop = true;
          UEFI.Output.Resolution = "1366x768";
          UEFI.Output.TextRenderer = "BuiltinGraphics";
          Misc.Boot.PickerMode = "External";
          Misc.Boot.PickerVariant = "Acidanthera\\Syrah";
          Misc.Boot.PickerAttributes = 17;
          Misc.Boot.Timeout = 10;
          Misc.Security.SecureBootModel = "Disabled";
          Misc.Security.ScanPolicy = 0;
          UEFI.Quirks.DisableSecurityPolicy = true;
          UEFI.Quirks.ReleaseUsbOwnership = true;
          PlatformInfo.Automatic = true;
          PlatformInfo.Generic.SystemProductName = "MacBookPro16,1";
          PlatformInfo.Generic.SystemSerialNumber = "C02DF0Y0MD6N";
          PlatformInfo.Generic.SystemUUID = "5445524E-A59B-4D8B-9B2F-9876543210AB";

          Misc.Entries = [
            {
              Name = "Limine";
              Enabled = true;
              Path = "PciRoot(0x0)/Pci(0x1f,0x2)/Sata(2,0,0)/HD(1,GPT,73ae5e9a-c31d-4787-9792-ee1843de3e9d,0x800,0x200000)/\\EFI\\limine\\BOOTX64.EFI";
            }
          ];

          UEFI.Drivers = [
            { Path = "OpenRuntime.efi"; Enabled = true; }
            { Path = "OpenCanopy.efi"; Enabled = true; }
            { Path = "OpenLinuxBoot.efi"; Enabled = true; }
            { Path = "OpenUsbKbDxe.efi"; Enabled = true; }
          ];
        };
      })
    ];
  };

  limineConf = pkgs.writeText "limine.conf" ''
    TIMEOUT=5
    GRAPHICS=yes
    INTERFACE_RESOLUTION=1366x768

    :NixOS (Systemd-Boot)
        PROTOCOL=chainload
        PATH=boot:///EFI/systemd/systemd-bootx64.efi
  '';

in
{
  system.activationScripts.opencoreConfig = {
    text = ''
      echo "--- Kopurando In1t ---"
      
      mkdir -p ${ocPath}/Drivers
      mkdir -p ${ocPath}/Resources
      mkdir -p ${liminePath}

      cp -f ${ocPkg}/X64/EFI/OC/Drivers/*.efi ${ocPath}/Drivers/
      cp -rf ${ocResources}/Resources/* ${ocPath}/Resources/
      
      if [ -f ${pkgs.limine}/share/limine/BOOTX64.EFI ]; then
        cp -f ${pkgs.limine}/share/limine/BOOTX64.EFI ${liminePath}/BOOTX64.EFI
      fi

      OC_PLIST_PATH=$(find ${ocConfig.efiPackage} -name "config.plist" | head -n 1)
      cp -f "$OC_PLIST_PATH" ${ocPath}/config.plist
      
      cp -f ${limineConf} ${liminePath}/limine.conf

      if ! ${pkgs.efibootmgr}/bin/efibootmgr | grep -q "OpenCore_Copland"; then
        ${pkgs.efibootmgr}/bin/efibootmgr -c -d /dev/sda -p 1 -L "OpenCore_Copland" -l "\EFI\OC\OpenCore.efi"
      fi
    '';
  };
}
