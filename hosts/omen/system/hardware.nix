{ pkgs, ... }: {
  custom = {
    intel-rocketlake = {
      enable = true;
      dri-symlink = {
        pci-address = "0000:00:02.0";
        path = "dri/intel-igpu";
      };
    };
    nvidia = {
      disabled-specialization.enable = true;
      prime = {
        enable = true;
        egl-vendor-library-filenames-json = "${pkgs.mesa.out}/share/glvnd/egl_vendor.d/50_mesa.json";
        vk-driver-files-json = "${pkgs.mesa.out}/share/vulkan/icd.d/intel_icd.x86_64.json";
      };
    };
  };

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
      };
    };
  };

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];
}
