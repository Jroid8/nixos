{ pkgs, inputs, ... }:
{
  imports = [
    inputs.hardware.nixosModules.common-gpu-nvidia
  ];

  hardware.nvidia.prime = {
    intelBusId = "PCI:0@0:2:0";
    nvidiaBusId = "PCI:1@0:0:0";
    offload = {
      enable = true;
      enableOffloadCmd = false;
    };
  };
  environment = {
    variables = {
      __EGL_VENDOR_LIBRARY_FILENAMES = "${pkgs.mesa.out}/share/glvnd/egl_vendor.d/50_mesa.json";
      VK_DRIVER_FILES = "${pkgs.mesa.out}/share/vulkan/icd.d/intel_icd.x86_64.json";
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
}
