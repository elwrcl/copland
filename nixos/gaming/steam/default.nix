{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    package = pkgs.steam.override {
      extraPkgs = p: with p; [
        liberation_ttf
        wqy_zenhei
        corefonts
        vista-fonts
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libgpg-error
        libkrb5
        keyutils
        bash
        coreutils
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        gamemode
        zenity
      ];
    };
    gamescopeSession.enable = true;
  };
  programs.bash.enable = true;
}
