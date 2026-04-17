{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "sleep 2 && noctalia-shell"
      "hyprctl setcursor Bibata-Modern-Classic 24"
      "easyeffects --hide-window --service-mode"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    ];
  };
}
