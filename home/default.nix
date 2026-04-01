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

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = { x = 10; y = 10; };
        opacity = 0.8;
        blur = true;
      };
      font = {
        normal = { family = "JetBrainsMono Nerd Font"; style = "Regular"; };
        bold = { family = "JetBrainsMono Nerd Font"; style = "Bold"; };
        italic = { family = "JetBrainsMono Nerd Font"; style = "Italic"; };
        size = 11.0;
      };
      terminal.shell = "zsh";
    };
  };

  xdg.configFile = {
    "fastfetch".source = ./dots/fastfetch;
    "fish/conf.d".source = ./dots/fish/conf.d;
  };

  home.packages = with pkgs; [
    eza bat fzf fd micro fastfetch starship
    vulkan-tools libva-utils mesa-demos intel-gpu-tools clinfo
    nerd-fonts.symbols-only zoxide trash-cli rsync

    inputs.apple-fonts.packages.${system}.sf-pro
    inputs.apple-fonts.packages.${system}.sf-mono
  ];

  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true; 
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
}