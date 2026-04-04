{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "doom";
      margin_box_h = 2;
      margin_box_v = 1;
      hide_borders = false;
      bigclock = true;
    };
  };
  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };
}