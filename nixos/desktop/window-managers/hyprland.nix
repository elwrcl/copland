{ pkgs, lib, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.hyprland.default = lib.mkForce [
      "hyprland"
      "gtk"
    ];
  };

  services = {
    dbus.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    gnome = {
      gnome-keyring.enable = true;
      gnome-settings-daemon.enable = lib.mkDefault false;
    };
  };

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    glib
    dconf
    dconf-editor
    xdg-utils
    xdg-user-dirs
  ];
}
