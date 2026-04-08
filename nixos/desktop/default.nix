{ pkgs, ... }:

{
  imports = [
    ./display
    ./window-managers
    ./audio
  ];

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/html"                = "zen-beta.desktop";
      "x-scheme-handler/http"   = "zen-beta.desktop";
      "x-scheme-handler/https"  = "zen-beta.desktop";
      "x-scheme-handler/about"  = "zen-beta.desktop";
      "x-scheme-handler/unknown"= "zen-beta.desktop";
      "image/png"     = "org.kde.gwenview.desktop";
      "image/jpeg"    = "org.kde.gwenview.desktop";
      "image/gif"     = "org.kde.gwenview.desktop";
      "image/bmp"     = "org.kde.gwenview.desktop";
      "image/svg+xml" = "org.kde.gwenview.desktop";
      "image/webp"    = "org.kde.gwenview.desktop";
      "image/tiff"    = "org.kde.gwenview.desktop";
      "video/mp4"        = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm"       = "mpv.desktop";
      "video/avi"        = "mpv.desktop";
      "video/quicktime"  = "mpv.desktop";
      "audio/mpeg"       = "mpv.desktop";
      "audio/flac"       = "mpv.desktop";
      "audio/ogg"        = "mpv.desktop";
      "text/plain"                = "code.desktop";
      "text/x-rust"               = "code.desktop";
      "text/x-nix"                = "code.desktop";
      "text/x-csrc"               = "code.desktop";
      "text/x-chdr"               = "code.desktop";
      "text/x-python"             = "code.desktop";
      "text/x-shellscript"        = "code.desktop";
      "application/json"          = "code.desktop";
      "application/x-shellscript" = "code.desktop";
    };
  };
}
