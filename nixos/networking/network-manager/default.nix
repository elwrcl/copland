{ ... }:

{
  networking.hostName = "copland";
  networking.networkmanager.enable = true;

  services.resolved = {
    enable = true;

    settings = {
      Resolve = {
        DNS = "1.1.1.1";
        DNSOverTLS = "yes";
        DNSSEC = "false";
        Domains = [ "~." ];
        FallbackDNS = [ "1.1.1.1" "8.8.8.8" ];
      };
    };
  };
}
