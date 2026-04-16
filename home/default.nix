{
  pkgs,
  ...
}:
{
  imports = [
    ./hyprland.nix
  ];

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

  # Alternatifsiz tek shell.
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
  };
  home.packages = with pkgs; [
    eza
    bat
    fd
    fastfetch
    vulkan-tools
    libva-utils
    mesa-demos
    intel-gpu-tools
    clinfo
    trash-cli
    rsync
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
      show-hidden-files = true;
    };
    "org/gtk/settings/file-chooser" = {
      sort-directories-first = true;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.theme = null;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}
