{ config, pkgs, ... }:
{
  time.timeZone = "Europe/Istanbul";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };
  services.timesyncd.enable = false;

  services.chrony = {
    enable = true;
    extraConfig = ''
      makestep 1.0 -1
      server 162.159.200.1 iburst
      server 216.239.35.0 iburst
      server time.cloudflare.com iburst
      server time.google.com iburst
    '';
  };

  systemd.services.chronyd = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
  };
  console.keyMap = "trq";
  system.stateVersion = "25.05";
}

