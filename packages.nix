{ pkgs }:
let
  uxplay-fixed = pkgs.uxplay.override {
    avahi = pkgs.avahi.override { withLibdnssdCompat = true; };
  };
in
with pkgs;
{
  system = [
    # diagnostic
    dmidecode
    lshw
    pciutils
    usbutils
    hwinfo
    efibootmgr
    cpuid
    smartmontools
    gsmartcontrol
    lm_sensors
    ddcutil
    brightnessctl
    libmtp
    jmtpfs
    btop
    fastfetch
    wget
    curl
    unzip
    zip
    p7zip
    rar
    dos2unix
    jq
    parted
    libqalculate
    qalculate-gtk
    direnv
    cachix
    ollama
    antigravity

    # network
    zapret
    autossh
    glib-networking

    # gaming
    heroic
    bottles
    prismlauncher
    virt-manager
    libvirt
    qemu
    wine

    # dev tools
    git
    gnumake
    pkg-config
    binutils
    openssl
    openssl.dev
    sqlite
    hidapi
    solaar
    xdotool
    cargo-tauri
    trunk
    dioxus-cli
    picotool
    stripe-cli
    nil
    nixpkgs-fmt

    # languages
    gcc
    rustup
    python3
    jdk
    go
    zig
    odin
    uv
    ghc
    cabal-install
    lua
    luajit
    zlib
    glibc
    glib
    libGL
    glm

    # desktop environment
    waybar
    wofi
    fuzzel
    swaylock
    swayidle
    eww
    bibata-cursors
    flatpak
    feh
    wl-clipboard
    grim
    slurp
    imagemagick
    tesseract
    wf-recorder
    shared-mime-info

    # graphics & display
    mesa
    adwaita-qt
    adwaita-qt6
    gsettings-desktop-schemas
    kdePackages.qtmultimedia
    qt6Packages.qtbase
    qt6Packages.qttools
    qt6Packages.qtsvg
    qt6Packages.qtdeclarative
    qt6Packages.qtwayland
    qt6Packages.qtwebsockets
    libsoup_3
    gtk3
    webkitgtk_4_1

    # media
    mpv
    ffmpeg
    yt-dlp
    obs-studio
    cava
    easyeffects
    pavucontrol
    playerctl
    pamixer
    alsa-utils
    alsa-lib
    aubio
    spotatui

    # editors
    vim
    micro
    neovim
    helix
    vscode
    (zed-editor.override { withGLES = true; })

    # apps
    firefox
    chromium
    thunderbird
    telegram-desktop
    discord
    equibop
    slack
    whatsapp-electron
    ghostty
    alacritty
    kitty
    nautilus
    loupe
    spacedrive
    onlyoffice-desktopeditors
    sioyek
    qbittorrent
    localsend
    jellyfin-media-player
    calibre
    ani-cli
    blender

    # mobile
    libimobiledevice
    ifuse
    usbmuxd
    uxplay-fixed

    # fonts & icons
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove
    noto-fonts-cjk-sans
    material-symbols
    nixos-icons
    papirus-icon-theme
    adwaita-icon-theme
    gnome-icon-theme
    hicolor-icon-theme
    pantheon.elementary-icon-theme
    tango-icon-theme
    arc-icon-theme
    gnome-themes-extra
  ];
}
