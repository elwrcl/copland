{ config, lib, pkgs, ... }:

let
  wayland-intel-vaapi-driver = pkgs.intel-vaapi-driver.overrideAttrs (oldAttrs: {
    version = "2.4.4-wayland-fix";
    src = pkgs.fetchFromGitHub {
      owner = "irql-notlessorequal";
      repo = "intel-vaapi-driver";
      rev = "929e936ec1f451a5daa12b0c7367687b712b8c2c";
      hash = "sha256-tZ1rZ+4bRxarcFQhP8V2Mfz0sJ5rBgHYLu2ulrQwL+U=";
    };
  });

  wayland-intel-vaapi-driver-32 = pkgs.pkgsi686Linux.intel-vaapi-driver.overrideAttrs (oldAttrs: {
    version = "2.4.4-wayland-fix";
    src = pkgs.fetchFromGitHub {
      owner = "irql-notlessorequal";
      repo = "intel-vaapi-driver";
      rev = "929e936ec1f451a5daa12b0c7367687b712b8c2c";
      hash = "sha256-tZ1rZ+4bRxarcFQhP8V2Mfz0sJ5rBgHYLu2ulrQwL+U=";
    };
  });
in
{
  hardware.graphics.extraPackages = [
    wayland-intel-vaapi-driver
    pkgs.libvdpau-va-gl
  ];

  hardware.graphics.extraPackages32 = [
    wayland-intel-vaapi-driver-32
    pkgs.pkgsi686Linux.libvdpau-va-gl
  ];

  services.xserver.videoDrivers = [ "modesetting" ];

  environment.variables = {
    LIBVA_DRIVER_NAME = "i965";
  };
}