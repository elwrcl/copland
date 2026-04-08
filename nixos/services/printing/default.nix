{ config, pkgs, ... }:

{
  services.printing = {
    enable = true;
    drivers = [ pkgs.cnijfilter2 pkgs.gutenprint pkgs.gutenprintBin ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };
}
