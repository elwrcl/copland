{
  pkgs,
  inputs,
  ...
}:
let
  packages = import ./packages.nix { inherit pkgs; };
  system = pkgs.system;
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
    inputs.zen-browser.packages.${system}.default
    inputs.noctalia.packages.${system}.default
    inputs.copetch.packages.${system}.default
  ];

  environment.pathsToLink = [
    "/share/applications"
    "/share/icons"
    "/share/mime"
  ];
}
