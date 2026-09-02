{ lib, config, ... }: {
  options = {
    custom.nvidia.disabled-specialization = {
      enable = lib.mkEnableOption "disabled nvidia specialisation";
    };
  };
  config = lib.mkIf config.custom.nvidia.disabled-specialization {
    specialisation.battery-saver = {
      configuration = lib.mkIf config.hardware.nvidia.prime.offload.enable {
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
  };
}
