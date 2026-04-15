{ ... }:

{
  imports = [
    ./display
    ./window-managers
    ./audio
  ];

  xdg.mime = {
    enable = true;
    defaultApplications = {
      # gui/web
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "x-scheme-handler/about" = "zen-beta.desktop";
      "x-scheme-handler/unknown" = "zen-beta.desktop";

      # media
      "image/png" = "org.gnome.Loupe.desktop";
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/gif" = "org.gnome.Loupe.desktop";
      "image/bmp" = "org.gnome.Loupe.desktop";
      "image/svg+xml" = "org.gnome.Loupe.desktop";
      "image/webp" = "org.gnome.Loupe.desktop";
      "image/tiff" = "org.gnome.Loupe.desktop";
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/avi" = "mpv.desktop";
      "video/quicktime" = "mpv.desktop";
      "audio/mpeg" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";

      # code
      "text/plain" = "code.desktop";
      "text/x-rust" = "code.desktop";
      "text/x-nix" = "code.desktop";
      "text/x-csrc" = "code.desktop";
      "text/x-chdr" = "code.desktop";
      "text/x-python" = "code.desktop";
      "text/x-shellscript" = "code.desktop";
      "application/json" = "code.desktop";
      "application/x-shellscript" = "code.desktop";
    };
  };
}
