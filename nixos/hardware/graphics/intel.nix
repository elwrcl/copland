{ config, lib, pkgs, ... }:

{
  hardware.graphics.extraPackages = with pkgs; [
    intel-vaapi-driver
    libvdpau-va-gl
    intel-media-driver
  ];

  hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [
    intel-vaapi-driver
    libvdpau-va-gl
  ];

  services.xserver.videoDrivers = [ "modesetting" ];

  environment.variables = {
    LIBVA_DRIVER_NAME = "i965";
    LIBVA_DRM_DEVICE = "/dev/dri/renderD128";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/intel_hasvk_icd.x86_64.json";
  };
}
