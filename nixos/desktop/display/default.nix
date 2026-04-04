{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "colormix";
      colormix_col1 = "0x00CC00FF";   # bright violet/purple
      colormix_col2 = "0x000000EE";   # deep blue
      colormix_col3 = "0x00880099";   # mid purple

      bigclock = "en";
      bigclock_12hr = false;

      fg          = "0x00FFFFFF";
      bg          = "0x00000000";
      border_fg   = "0x00FFFFFF";
      error_fg    = "0x01FF0000";
      blank_box   = true;
      hide_borders = false;

      margin_box_h = 2;
      margin_box_v = 1;
    };
  };
  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };
}