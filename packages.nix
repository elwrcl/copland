{ pkgs }:
let
  uxplay-fixed = pkgs.uxplay.override {
    avahi = pkgs.avahi.override { withLibdnssdCompat = true; };
  };
in
with pkgs;
{
  system = [
    # android
    libmtp
    jmtpfs

    # ip
    libimobiledevice
    ifuse
    usbmuxd
    uxplay-fixed

    # virt
    virt-manager
    libvirt
    qemu

    # hrd
    ddcutil
    libsecret
    brightnessctl
    lm_sensors
    smartmontools
    gsmartcontrol
    parted
  ];
}
