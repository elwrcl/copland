{ pkgs }:
with pkgs; {
  system = [
    # Gaming
    heroic
    bottles
    prismlauncher

    # Networking
    zapret

    # Hardware
    kdePackages.qtmultimedia
    qt6Packages.qtbase
    qt6Packages.qttools
    qt6Packages.qtsvg
    qt6Packages.qtdeclarative
    qt6Packages.qtwayland
    qt6Packages.qtwebsockets
    adwaita-qt
    adwaita-qt6
    mesa
    cava
    direnv

    # MTP support for Android devices
    libmtp
    jmtpfs
    rar

    # Iphone stuff
    libimobiledevice
    ifuse
    usbmuxd
    uxplay

    # Virtualization
    virt-manager
    libvirt
    qemu

    # Desktop
    bibata-cursors
    flatpak
    fuzzel
    swaylock
    swayidle
    feh
    spotatui
    whatsapp-electron
    ffmpeg
    sioyek
    gsmartcontrol
    smartmontools
    eww
    qbittorrent
    localsend
    jellyfin-media-player
    parted
    ollama
    alacritty
    antigravity

    # Development tools
    git
    hidapi
    cachix
    dos2unix
    alsa-lib
    gnumake
    unzip
    luajit
    btop
    fastfetch
    ddcutil
    brightnessctl
    lm_sensors
    fish
    openssl
    openssl.dev
    solaar
    aubio
    docker-compose
    swappy
    cargo-tauri
    trunk
    libqalculate
    material-symbols
    nerd-fonts.caskaydia-cove
    kitty
    slack
    dioxus-cli
    sqlite
    picotool
    stripe-cli
    chromium
    autossh
    glib-networking
    libsoup_3
    gtk3
    webkitgtk_4_1
    xdotool
    easyeffects
    nil
    nixpkgs-fmt
    direnv

    # Editors
    vim
    micro
    neovim
    helix
    vscode
    zed-editor

    # Languages
    uv
    pkg-config
    odin
    ghc
    cabal-install
    go
    rustup
    gcc
    binutils
    libGL
    wget
    glm
    glib
    glibc
    zlib
    zig
    lua

    # Hyprland
    waybar
    wofi

    # Desktop tools
    obs-studio
    tesseract
    jq
    wf-recorder
    yt-dlp
    wl-clipboard
    grim
    slurp
    imagemagick
    nixos-icons
    papirus-icon-theme
    adwaita-icon-theme
    gnome-icon-theme
    hicolor-icon-theme
    pantheon.elementary-icon-theme
    tango-icon-theme
    arc-icon-theme
    shared-mime-info
    qalculate-gtk
    kdePackages.gwenview
    mpv
    equibop
    discord
    pavucontrol
    playerctl
    pamixer
    alsa-utils
    zip
    p7zip
    calibre
    ani-cli
    gnome-themes-extra

    # Fonts
    noto-fonts-cjk-sans
    nerd-fonts.jetbrains-mono

    # Applications
    thunderbird
    firefox
    telegram-desktop
    ghostty
    onlyoffice-desktopeditors
    nautilus
    wine
  ];
}
