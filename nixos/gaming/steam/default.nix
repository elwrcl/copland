{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    package = pkgs.steam.override {
      extraEnv = {
        STEAM_USE_PORTAL = "1";
        GTK_USE_PORTAL = "1";
        PRESSURE_VESSEL_VERBOSE = "0";
      };
      extraPkgs =
        p: with p; [
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
          # pressure-vessel için gerekli
          glib
          dbus
          at-spi2-atk
          atk
          pkgsi686Linux.libgcc
          pkgsi686Linux.glibc
          pkgsi686Linux.mesa
          pkgsi686Linux.libGL
          pkgsi686Linux.libpulseaudio
        ];
    };
    gamescopeSession.enable = true;
  };
  programs.bash.enable = true;
  hardware.graphics.enable = true;
  environment.systemPackages = with pkgs; [
    protontricks
  ];
}
