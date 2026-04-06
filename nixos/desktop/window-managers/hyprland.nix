{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment.sessionVariables = {
   XDG_DATA_DIRS = [
    "/run/current-system/sw/share"
    "/home/elars/.nix-profile/share"
  ];
   GTK_USE_PORTAL = "1";
};
}
