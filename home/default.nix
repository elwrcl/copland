{ config, pkgs, inputs, system, ... }:

{
  imports = [ ./hyprland.nix ];

  home.username = "elars";
  home.homeDirectory = "/home/elars";
  home.stateVersion = "25.05";

  programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  initContent = builtins.readFile ./dots/zsh/.zshrc;
  };

  programs.kitty = {
    enable = true;
    settings = {
      shell = "zsh";
      confirm_os_window_close = 0;
      background_opacity = "0.8";
      cursor_trail = 3;
    };
  };

  xdg.configFile = {
    "fastfetch".source = ./dots/fastfetch;
    "fish/conf.d".source = ./dots/fish/conf.d;
  };

  # Packs
  home.packages = with pkgs; [
    eza bat fzf fd micro fastfetch starship
    vulkan-tools libva-utils mesa-demos intel-gpu-tools clinfo
    nerd-fonts.symbols-only

    inputs.apple-fonts.packages.${system}.sf-pro
    inputs.apple-fonts.packages.${system}.sf-mono
  ];

  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
  services.kdeconnect.enable = true;
}
