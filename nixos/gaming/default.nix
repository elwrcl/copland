{ pkgs, ... }:

{
  imports = [
    ./steam
  ];

  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  environment.systemPackages = with pkgs; [
    protonup-qt
    mangohud
  ];
}