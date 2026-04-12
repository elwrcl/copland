{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    package = pkgs.steam.override {
      extraPkgs = p: with p; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        liberation_ttf
        wqy_zenhei
        corefonts
        vista-fonts
        libXcursor
        libXi
        libXinerama
        libXScrnSaver
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
        pkgsi686Linux.libgcc
        pkgsi686Linux.glibc
        pkgsi686Linux.mesa
      ];
    };
    gamescopeSession.enable = true;
  };
  programs.bash.enable = true;
}
