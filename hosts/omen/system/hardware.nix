{ pkgs, lib, ... }: {
  boot = {
    initrd.kernelModules = [ "i915" ];
    kernelParams = [ "i915.enable_guc=3" ];
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

    cpu.intel.updateMicrocode = true;

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime-legacy1
      ];
    };

    nvidia = {
      open = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      prime = {
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = false;
        };
      };
    };
  };

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  environment = {
    variables = {
      LIBVA_DRIVER_NAME = "iHD";
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

  services.udev.extraRules = ''
    KERNEL=="card*", KERNELS=="0000:00:02.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/intel-igpu"
  '';

  specialisation = {
    battery-saver.configuration = {
      system.nixos.tags = [ "battery-saver" ];
      boot.extraModprobeConfig = ''
        blacklist nouveau
        options nouveau modeset=0
      '';
      services.udev.extraRules = ''
        # Remove NVIDIA USB xHCI Host Controller devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"

        # Remove NVIDIA USB Type-C UCSI devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"

        # Remove NVIDIA Audio devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"

        # Remove NVIDIA VGA/3D controller devices
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
      '';
      boot.blacklistedKernelModules = [
        "nouveau"
        "nvidia"
        "nvidia_drm"
        "nvidia_modeset"
      ];
      hardware.nvidia = {
        prime.offload.enable = lib.mkForce false;
        powerManagement = {
          enable = lib.mkForce false;
          finegrained = lib.mkForce false;
        };
      };
      services.xserver.videoDrivers = lib.mkForce [ "modesetting" ];
    };
  };
}
