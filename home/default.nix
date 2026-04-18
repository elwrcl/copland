{
  pkgs,
  inputs,
  system,
  ...
}:

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
  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.home-manager.enable = true;

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk4 = {
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
    };
  };

  home.sessionVariables = {
    BROWSER = "zen-beta.desktop";
  };

  xdg.configFile = {
    "fastfetch".source = ./dots/fastfetch;
    "fish/conf.d".source = ./dots/fish/conf.d;
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      "x-scheme-handler/http" = [ "zen-beta.desktop" ];
      "x-scheme-handler/https" = [ "zen-beta.desktop" ];
      "x-scheme-handler/about" = [ "zen-beta.desktop" ];
      "x-scheme-handler/unknown" = [ "zen-beta.desktop" ];
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-application-prefer-dark-theme = true;
      gtk-theme = "Adwaita-dark";
    };
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
    };
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [

    # cli
    eza
    bat
    ani-cli
    fd
    micro
    fastfetch
    zoxide
    trash-cli
    rsync
    tldr
    jq
    zip
    p7zip
    rar
    dos2unix
    unzip
    wget
    autossh
    direnv
    fish
    git
    cachix
    btop
    alacritty
    kitty
    xdg-utils

    # hardware
    hidapi
    vulkan-tools
    libva-utils
    mesa-demos
    intel-gpu-tools
    clinfo

    # desktop
    xdotool
    wl-clipboard
    waybar
    wofi
    fuzzel
    swaylock
    swayidle
    feh
    eww
    easyeffects
    swappy
    grim
    slurp
    wf-recorder
    tesseract

    # media
    mpv
    obs-studio
    ffmpeg
    yt-dlp
    imagemagick
    cava
    pavucontrol
    playerctl
    pamixer

    # editors
    vim
    neovim
    helix
    vscode
    zed-editor

    # dev tools
    nil
    github-copilot-cli
    nixpkgs-fmt
    gnumake
    sqlite
    picotool
    stripe-cli
    openssl
    pkg-config
    aubio
    docker-compose
    cargo-tauri
    trunk
    dioxus-cli
    uv

    # langs
    ghc
    go
    rustup
    gcc
    binutils
    zig
    lua
    glm

    # themes and icons
    bibata-cursors
    gnome-themes-extra
    papirus-icon-theme
    adwaita-icon-theme
    adwaita-qt6
    gnome-icon-theme
    hicolor-icon-theme
    pantheon.elementary-icon-theme
    tango-icon-theme
    arc-icon-theme

    # apps
    heroic
    bottles
    prismlauncher
    telegram-desktop
    onlyoffice-desktopeditors
    nautilus
    loupe
    qbittorrent
    localsend
    jellyfin-media-player
    calibre
    qalculate-gtk
    libqalculate
    blender
    wine
    antigravity
    spotatui
    whatsapp-electron
    equibop
    discord
  ];
}
