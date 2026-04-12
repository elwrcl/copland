{ config, pkgs, ... }:

{
  imports = [
    ./hyprland/env.nix
    ./hyprland/execs.nix
    ./hyprland/general.nix
    ./hyprland/rules.nix
    ./hyprland/keybinds.nix
  ];
}
