{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.custom.nvidia.prime;
in
{
  options = {
    custom.nvidia-prime = {
      enable = lib.mkEnableOption "customized nvidia prime";
      egl-vendor-library-filenames-json = lib.options.mkOption {
        type = lib.types.pathInStore;
      };
      vk-driver-files-json = lib.options.mkOption {
        type = lib.types.pathInStore;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.nvidia.prime.offload = {
      enable = true;
      enableOffloadCmd = false;
    };

    environment = {
      variables = {
        __EGL_VENDOR_LIBRARY_FILENAMES = cfg.egl-vendor-library-filenames-json;
        VK_DRIVER_FILES = cfg.vk-driver-files-json;
        __GLX_VENDOR_LIBRARY_NAME = "mesa";
      };
      systemPackages = [
        (pkgs.writeShellApplication {
          name = "prime-run";
          text = ''
            unset __EGL_VENDOR_LIBRARY_FILENAMES
            unset VK_DRIVER_FILES
            export __NV_PRIME_RENDER_OFFLOAD=1
            export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
            export __GLX_VENDOR_LIBRARY_NAME=nvidia
            export __VK_LAYER_NV_optimus=NVIDIA_only
            exec "$@"
          '';
        })
      ];
    };
  };
}
