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
in
{
  system.activationScripts.opencoreConfig = {
    text = ''
            echo "--- Copland Bootloader ---"
      
            mkdir -p ${ocPath}/Drivers
            mkdir -p ${ocPath}/Resources
            mkdir -p ${liminePath}

            cp -f ${ocPkg}/X64/EFI/OC/Drivers/*.efi ${ocPath}/Drivers/
            cp -rf ${ocResources}/Resources/* ${ocPath}/Resources/
      
            if [ -f ${pkgs.limine}/share/limine/BOOTX64.EFI ]; then
              cp -f ${pkgs.limine}/share/limine/BOOTX64.EFI ${liminePath}/BOOTX64.EFI
            fi

            cat <<EOF > ${liminePath}/limine.conf
      TIMEOUT=5
      GRAPHICS=yes
      INTERFACE_RESOLUTION=1366x768

      :NixOS (CachyOS)
          PROTOCOL=linux
          KERNEL_PATH=boot:///EFI/nixos/j2rky4bwgy6s1d5j15pvz4yiprhm96j2-linux-cachyos-latest-lto-x86_64-v2-6.19.11-bzImage.efi
          MODULE_PATH=boot:///EFI/nixos/bfy4s8c3lhhdqqpw0ys5gik4vs6hyjlz-initrd-linux-cachyos-latest-lto-x86_64-v2-6.19.11-initrd.efi
          CMDLINE=preempt=full i915.enable_fbc=1 mitigations=off "i915.enable_fbc=1" "usbcore.autosuspend=-1" "transparent_hugepage=always"
      EOF

            cat <<EOF > ${ocPath}/config.plist
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>Booter</key>
          <dict>
              <key>Quirks</key>
              <dict>
                  <key>AvoidRuntimeDefrag</key><true/>
                  <key>EnableWriteUnprotector</key><true/>
                  <key>ProvideCustomSlide</key><true/>
                  <key>SetupVirtualMap</key><true/>
              </dict>
          </dict>

          <key>Misc</key>
          <dict>
              <key>Boot</key>
              <dict>
                  <key>PickerMode</key><string>External</string>
                  <key>PickerAttributes</key><integer>17</integer>
                  <key>Timeout</key><integer>5</integer>
                  <key>ShowPicker</key><true/>
              </dict>
              <key>Entries</key>
              <array>
                  <dict>
                      <key>Name</key><string>Limine</string>
                      <key>Enabled</key><true/>
                      <key>Path</key><string>PciRoot(0x0)/Pci(0x1f,0x2)/Sata(2,0,0)/HD(1,GPT,73ae5e9a-c31d-4787-9792-ee1843de3e9d,0x800,0x200000)/\EFI\limine\BOOTX64.EFI</string>
                  </dict>
              </array>
              <key>Security</key>
              <dict>
                  <key>AllowSetDefault</key><true/>
                  <key>ScanPolicy</key><integer>0</integer>
                  <key>Vault</key><string>Optional</string>
              </dict>
          </dict>

          <key>UEFI</key>
          <dict>
              <key>Input</key>
              <dict>
                  <key>KeySupport</key><true/>
                  <key>KeySupportMode</key><string>Auto</string>
              </dict>
              <key>Output</key>
              <dict>
                  <key>ProvideConsoleGop</key><true/>
                  <key>Resolution</key><string>1366x768</string>
                  <key>TextRenderer</key><string>BuiltinGraphics</string>
              </dict>
              <key>Quirks</key>
              <dict>
                  <key>ReleaseUsbOwnership</key><true/>
              </dict>
              <key>Drivers</key>
              <array>
                  <string>OpenRuntime.efi</string>
                  <string>OpenCanopy.efi</string>
                  <string>OpenLinuxBoot.efi</string>
                  <string>OpenUsbKbDxe.efi</string>
              </array>
          </dict>
      </dict>
      </plist>
      EOF

            if ! ${pkgs.efibootmgr}/bin/efibootmgr | grep -q "OpenCore_Copland"; then
              ${pkgs.efibootmgr}/bin/efibootmgr -c -d /dev/sda -p 1 -L "OpenCore_Copland" -l "\EFI\OC\OpenCore.efi"
            fi
    '';
  };
}
