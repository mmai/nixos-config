{config, pkgs, lib, ...}: 
let
  nvStable = config.boot.kernelPackages.nvidiaPackages.stable;
  nvBeta = config.boot.kernelPackages.nvidiaPackages.beta;
  nvidiaPkg =
    if (lib.versionOlder nvBeta.version nvStable.version) then
      config.boot.kernelPackages.nvidiaPackages.stable
    else
      config.boot.kernelPackages.nvidiaPackages.beta;
in
{
  services.xserver = {
      videoDrivers = [ "nvidia" ];
  };

  environment.sessionVariables = {
      WLR_DRM_NO_ATOMIC = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      MOZ_DISABLE_RDD_SANDBOX = "1";
      EGL_PLATFORM = "wayland";
    };
  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  environment.systemPackages = with pkgs; [
    glxinfo
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];

  hardware = {
    nvidia = {
      package = nvidiaPkg;
      open = false; # x fails with : nvidia card does not support 'open'
      modesetting.enable = true;
      nvidiaSettings = false;
      powerManagement.enable = false;
    };

    opengl = {
      extraPackages = with pkgs; [nvidia-vaapi-driver];
    };
  };
}
