{ pkgs, ... }:

{
  users.users.elars = {
    isNormalUser = true;
    description = "elars";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "video"
      "audio"
      "lp"
      "scanner"
      "libvirtd"
    ];
    shell = pkgs.zsh;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/elars/copland";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
}
