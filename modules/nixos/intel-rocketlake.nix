{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.intel-rocketlake;
in
{
  options = {
    custom.intel-rocketlake = {
      enable = lib.mkEnableOption "custom intel hardware config for rocketlake";
    };
  };
  config = lib.mkIf cfg.enable {
    boot = {
      initrd.kernelModules = [ "i915" ];
      kernelParams = [ "i915.enable_guc=3" ];
    };

    hardware = {
      cpu.intel.updateMicrocode = true;
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver
          intel-compute-runtime-legacy1
        ];
      };
    };

    environment.variables.LIBVA_DRIVER_NAME = "iHD";

    services.udev.extraRules = ''
      KERNEL=="card*", KERNELS=="0000:00:02.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/intel-igpu"
    '';
  };
}
