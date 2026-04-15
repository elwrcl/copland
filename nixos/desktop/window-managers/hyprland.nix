{ pkgs, lib, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "gtk" ];
        "org.freedesktop.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.portal.OpenURI" = [ "gtk" ];
        "org.freedesktop.portal.Email" = [ "gtk" ];
        "org.freedesktop.portal.Inhibit" = [ "gtk" ];
        "org.freedesktop.portal.Settings" = [ "gtk" ];
        "org.freedesktop.portal.Wallpaper" = [ "gtk" ];
        "org.freedesktop.portal.Notification" = [ "gtk" ];
        "org.freedesktop.portal.Account" = [ "gtk" ];
        "org.freedesktop.portal.Screenshot" = [ "hyprland" ];
        "org.freedesktop.portal.ScreenCast" = [ "hyprland" ];
      };
    };
  };
  services.dbus.enable = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.wireplumber.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gnome-settings-daemon.enable = lib.mkDefault false;
  environment.systemPackages = with pkgs; [
    gsettings-desktop-schemas
    glib
    dconf
    dconf-editor
    xdg-utils
    xdg-user-dirs
  ];

  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "/run/current-system/sw/share"
      "/home/elars/.nix-profile/share"
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    ];
    GTK_USE_PORTAL = "1";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
  };
}
