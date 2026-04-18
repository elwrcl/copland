{ pkgs }:
let
  uxplay-fixed = pkgs.uxplay.override {
    avahi = pkgs.avahi.override { withLibdnssdCompat = true; };
  };
in
with pkgs;
{
  system = [
    # phone
    libmtp
    jmtpfs
    libimobiledevice
    ifuse
    usbmuxd
    uxplay-fixed

    # vm
    virt-manager
    libvirt
    qemu

    # hardware
    ddcutil
    libsecret
    brightnessctl
    lm_sensors
    smartmontools
    gsmartcontrol
    parted
  ];
}
