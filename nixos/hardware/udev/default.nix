{ config, pkgs, ... }:

{
  services.udev.extraRules = ''
    KERNEL=="ttyACM[0-9]*", MODE="0666"
    KERNEL=="ttyUSB[0-9]*", MODE="0666"
    SUBSYSTEM=="input", ATTRS{idVendor}=="03f0", ATTRS{idProduct}=="0c91", ENV{ID_INPUT_KEY}=="1", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id.match("org.freedesktop.udisks2.") &&
            subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
    });
  '';
}
