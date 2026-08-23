{ pkgs, ... }: {
  imports = [
    ../../../modules/nixos/nvidia
    ../../../modules/nixos/intel-rocketlake.nix
  ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    enableRedistributableFirmware = true;
    firmware = with pkgs; [
      linux-firmware
      sof-firmware
    ];

    nvidia = {
      open = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      prime = {
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
        egl-vendor-library-filenames = "${pkgs.mesa.out}/share/glvnd/egl_vendor.d/50_mesa.json";
        vk-driver-files = "${pkgs.mesa.out}/share/vulkan/icd.d/intel_icd.x86_64.json";
      };
    };
  };

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];
}
