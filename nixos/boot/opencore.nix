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

  ocConfig = inputs.oceanix.lib.makeOC {
    inherit pkgs;
    config = {
      Booter.Quirks = {
        AvoidRuntimeDefrag = true;
        EnableWriteUnprotector = true;
        ProvideCustomSlide = true;
        SetupVirtualMap = true;
      };

      Misc = {
        Boot = {
          PickerMode = "External";
          PickerVariant = "Acidanthera\\Syrah";
          PickerAttributes = 17;
          ShowPicker = true;
          Timeout = 10;
        };
        Security = {
          AllowSetDefault = true;
          AuthRestart = false;
          BlacklistAppleUpdate = true;
          DmgLoading = "Signed";
          EnablePassword = false;
          ExposeSensitiveData = 6;
          HaltLevel = 2147483648;
          ScanPolicy = 0;
          SecureBootModel = "Disabled";
          Vault = "Optional";
        };
        Entries = [
          {
            Name = "Limine";
            Enabled = true;
            Path = "PciRoot(0x0)/Pci(0x1f,0x2)/Sata(2,0,0)/HD(1,GPT,73ae5e9a-c31d-4787-9792-ee1843de3e9d,0x800,0x200000)/\\EFI\\limine\\BOOTX64.EFI";
          }
        ];
      };

      PlatformInfo = {
        Automatic = true;
        UpdateDataHub = true;
        UpdateNVRAM = true;
        UpdateSMBIOS = true;
        UpdateSMBIOSMode = "Create";
        Generic = {
          AdviseFeatures = true;
          SystemProductName = "MacBookPro16,1";
          SystemSerialNumber = "C02DF0Y0MD6N";
          SystemUUID = "5445524E-A59B-4D8B-9B2F-9876543210AB";
        };
      };

      UEFI = {
        ConnectDrivers = true;
        Input = {
          KeySupport = true;
          KeySupportMode = "Auto";
        };
        Output = {
          ProvideConsoleGop = true;
          Resolution = "Max";
          TextRenderer = "BuiltinGraphics";
        };
        Quirks = {
          ReleaseUsbOwnership = true;
          RequestBootVarRouting = true;
          DisableSecurityPolicy = true;
        };
        Drivers = [
          { Path = "OpenRuntime.efi"; Enabled = true; }
          { Path = "OpenCanopy.efi"; Enabled = true; }
          { Path = "OpenLinuxBoot.efi"; Enabled = true; }
          { Path = "OpenUsbKbDxe.efi"; Enabled = true; }
        ];
      };
    };
  };

  limineConf = pkgs.writeText "limine.conf" ''
    TIMEOUT=5
    GRAPHICS=yes
    INTERFACE_RESOLUTION=1366x768

    :NixOS (Systemd-Boot)
        PROTOCOL=efi_chainload
        PATH=boot:///EFI/systemd/systemd-bootx64.efi
  '';

in
{
  system.activationScripts.opencoreConfig = {
    text = ''
      echo "--- Kōpurando ---"
      
      mkdir -p ${ocPath}/Drivers
      mkdir -p ${ocPath}/Resources
      mkdir -p ${liminePath}

      # copying files
      cp -f ${ocPkg}/X64/EFI/OC/Drivers/*.efi ${ocPath}/Drivers/
      cp -rf ${ocResources}/Resources/* ${ocPath}/Resources/
      
      if [ -f ${pkgs.limine}/share/limine/BOOTX64.EFI ]; then
        cp -f ${pkgs.limine}/share/limine/BOOTX64.EFI ${liminePath}/BOOTX64.EFI
      fi

      # .plists
      cp -f ${ocConfig}/config.plist ${ocPath}/config.plist
      cp -f ${limineConf} ${liminePath}/limine.conf

      # bios 
      if ! ${pkgs.efibootmgr}/bin/efibootmgr | grep -q "OpenCore_Copland"; then
        ${pkgs.efibootmgr}/bin/efibootmgr -c -d /dev/sda -p 1 -L "OpenCore_Copland" -l "\EFI\OC\OpenCore.efi"
      fi
    '';
  };
}
