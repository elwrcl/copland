{
  config,
  lib,
  pkgs,
  ...
}:

{
  systemd.tmpfiles.rules = [
    "d /var/lib/samba/usershares 0755 elars users -"
  ];

  environment.etc."samba/smbusers".text = ''
    nobody = guest
  '';

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        workgroup = "WORKGROUP";
        "server string" = config.networking.hostName;
        "netbios name" = config.networking.hostName;
        security = "user";
        "use sendfile" = "yes";
        "max protocol" = "SMB3";
        "min protocol" = "SMB2";
        "hosts allow" = "192.168.1.0/24 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "Bad User";
        "usershare path" = "/var/lib/samba/usershares";
        "usershare max shares" = "100";
        "usershare allow guests" = "yes";
        "usershare owner only" = "no";
        "usershare prefix allow list" = "/mnt /home";
        "idmap config * : backend" = "tdb";
        "idmap config * : range" = "3000-7999";
        "username map" = "/etc/samba/smbusers";
      };

      "HDD" = {
        path = "/mnt/HDD";
        browseable = "yes";
        public = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "guest only" = "yes";
        "create mask" = "0777";
        "directory mask" = "0777";
        "force user" = config.users.users.elars.name;
        "force group" = "users";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
