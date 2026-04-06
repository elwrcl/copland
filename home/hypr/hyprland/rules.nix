{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "float on,             match:title ^(Open File)(.*)$"
      "center on,            match:title ^(Open File)(.*)$"
      "float on,             match:title ^(Save As)(.*)$"
      "center on,            match:title ^(Save As)(.*)$"
      "float on,             match:title ^(File Upload)(.*)$"
      "center on,            match:title ^(File Upload)(.*)$"
      "float on,             match:class ^(pavucontrol)$"
      "center on,            match:class ^(pavucontrol)$"
      "size 45% 45%,         match:class ^(pavucontrol)$"
      "float on,             match:title ^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$"
      "pin on,               match:title ^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$"
      "keep_aspect_ratio on, match:title ^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$"
      "immediate on,         match:class ^(steam_app).*"
      "float on,             match:class ^(steam)$"
      "float off,            match:class ^(steam)$, match:title ^(Steam)$"s
    ];
  };
}