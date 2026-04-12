{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
    config = {
      common = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.portal.Screenshot" = [ "hyprland" ];
        "org.freedesktop.portal.ScreenCast" = [ "hyprland" ];
      };
    };
  };

  environment.etc."xdg/xdg-desktop-portal/portals/gtk.portal".text = ''
    [portal]
    DBusName=org.freedesktop.impl.portal.desktop.gtk
    Interfaces=org.freedesktop.impl.portal.FileChooser;org.freedesktop.impl.portal.AppChooser;org.freedesktop.impl.portal.Print;org.freedesktop.impl.portal.Notification;org.freedesktop.impl.portal.Inhibit;org.freedesktop.impl.portal.Access;org.freedesktop.impl.portal.Account;org.freedesktop.impl.portal.Email;org.freedesktop.impl.portal.DynamicLauncher;org.freedesktop.impl.portal.Lockdown;org.freedesktop.impl.portal.Settings;org.freedesktop.impl.portal.Wallpaper;
    UseIn=gnome;Hyprland
  '';

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "/run/current-system/sw/share"
      "/home/elars/.nix-profile/share"
    ];
    GTK_USE_PORTAL = "1";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
  };
}
