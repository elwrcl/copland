{ config, pkgs, inputs, system, ... }:

{
  imports = [ ./hyprland.nix ];

  home.username = "elars";
  home.homeDirectory = "/home/elars";
  home.stateVersion = "25.05";

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = builtins.readFile ./dots/zsh/.zshrc;
  };

  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 10;
      background-opacity = 0.8;
      window-padding-x = 10;
      window-padding-y = 10;
    };
  };

  xdg.configFile = {
    "fastfetch".source = ./dots/fastfetch;
    "fish/conf.d".source = ./dots/fish/conf.d;
  };

  home.packages = with pkgs; [
    eza
    bat
    fzf
    fd
    micro
    fastfetch
    starship
    vulkan-tools
    libva-utils
    mesa-demos
    intel-gpu-tools
    clinfo
    nerd-fonts.symbols-only
    zoxide
    trash-cli
    rsync

    inputs.apple-fonts.packages.${system}.sf-pro
    inputs.apple-fonts.packages.${system}.sf-mono
    nerd-fonts.jetbrains-mono
  ];

  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
  services.kdeconnect.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-application-prefer-dark-theme = true;
    };
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk3";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

  };
}
