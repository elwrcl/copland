{ config, pkgs, inputs, system, zen-browser, ... }:
let
  packages = import ./packages.nix { inherit pkgs; };
in
{
  imports = [
    ./hardware.nix
    ./nixos
  ];

  elars.hardware.graphics.driver = "intel";

  zramSwap = {
    enable = true;
    memoryPercent = 100;
    algorithm = "zstd";
    priority = 100;
  };

  environment.systemPackages = packages.system ++ [
    inputs.helium.packages.${system}.default
    zen-browser.packages.${system}.default
    inputs.noctalia.packages.${system}.default
  ];
}
