{ pkgs }:
# Note: gtk.gtk4.theme default changed in newer NixOS. To silence the
# evaluation warning you can set `gtk.gtk4.theme = null;` to adopt the new
# default, or `gtk.gtk4.theme = config.gtk.theme;` to keep legacy behavior.
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

    # qml/qt6
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtwayland
    libclang
  ];
}
