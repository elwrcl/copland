{ config, pkgs, ... }:

{
  networking.hostName = "copland";
  networking.networkmanager.enable = true;

services.resolved = {
  enable = true;
  dnssec = "false";
  domains = [ "~." ];
  fallbackDns = [ "1.1.1.1" "8.8.8.8" ];
  settings = {
    Resolve = {
      DNS = "1.1.1.1";
      DNSOverTLS = "yes";
    };
  };
};