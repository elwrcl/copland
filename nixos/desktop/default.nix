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
      "x-scheme-handler/steam" = "steam.desktop";

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
      "text/plain" = "zeditor.desktop";
      "text/x-rust" = "zeditor.desktop";
      "text/x-nix" = "zeditor.desktop";
      "text/x-csrc" = "zeditor.desktop";
      "text/x-chdr" = "zeditor.desktop";
      "text/x-python" = "zeditor.desktop";
      "text/x-shellscript" = "zeditor.desktop";
      "application/json" = "zeditor.desktop";
      "application/x-shellscript" = "zeditor.desktop";
    };
  };
}
