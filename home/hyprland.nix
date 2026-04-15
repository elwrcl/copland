{ ... }:

{
  imports = [
    ./hypr/default.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
  };
}
