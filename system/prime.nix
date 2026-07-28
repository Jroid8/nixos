{ pkgs, inputs, ... }:
{
  imports = [
    inputs.hardware.common.gpu.nvidia.prime
  ];

  hardware.nvidia.prime = {
    intelBusId = "PCI:0@0:2:0";
    nvidiaBusId = "PCI:1@0:0:0";
    offload = {
      enable = true;
      enableOffloadCmd = false;
    };
  };
  environment.systemPackages = [
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
}
