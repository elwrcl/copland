{ lib, pkgs, ... }:

{
  programs.niri.enable = true;
  xdg.portal.config.niri = {
    default = [ "gtk" ];
    "org.freedesktop.portal.FileChooser" = [ "gtk" ];
    "org.freedesktop.portal.Screenshot" = [ "gtk" ];
    "org.freedesktop.portal.ScreenCast" = [ "gtk" ];
  };
  environment.etc."xdg/xdg-desktop-portal/portals/gtk.portal".text = lib.mkForce ''
    [portal]
    DBusName=org.freedesktop.impl.portal.desktop.gtk
    Interfaces=org.freedesktop.impl.portal.FileChooser;org.freedesktop.impl.portal.AppChooser;org.freedesktop.impl.portal.Print;org.freedesktop.impl.portal.Notification;org.freedesktop.impl.portal.Inhibit;org.freedesktop.impl.portal.Access;org.freedesktop.impl.portal.Account;org.freedesktop.impl.portal.Email;org.freedesktop.impl.portal.DynamicLauncher;org.freedesktop.impl.portal.Lockdown;org.freedesktop.impl.portal.Settings;org.freedesktop.impl.portal.Wallpaper;
    UseIn=gnome;Hyprland;niri
  '';
}
