{ pkgs, modulesPath, ... }:
{
  imports = [
    ./doas.nix
    ./fonts.nix
    ./greet.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    # inputs.hardware.common.cpu.intel.comet-lake
    # inputs.hardware.common.gpu.nvidia.ampere
    # inputs.hardware.common.pc.laptop
    # inputs.hardware.common.pc.ssd
    (modulesPath + "/virtualisation/qemu-vm.nix")
  ];

  system.stateVersion = "26.05";

  virtualisation.qemu = {
    forceAccel = true;
    options = [
      "-m 4G"
			"-object memory-backend-memfd,id=mem,size=4G,share=on"
      "-audiodev pipewire,id=snd0"
      "-device ich9-intel-hda"
      "-device hda-output,audiodev=snd0"
      "-numa node,memdev=mem"
			# "-chardev socket,id=char0,path=/tmp/vm-share.sock"
			# "-device vhost-user-fs-pci,chardev=char0,tag=myfs"
    ];
  };

  # Kernel
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "amd_pstate=active" ];

  # GRUB
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    device = "/dev/disk/by-uuid/025F-70BD";
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Networking
  networking.hostName = "omen";
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;

  time.timeZone = "Asia/Tehran";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = [ "fa_IR/UTF-8" ];

  # Nix
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Users
  users.users.jroid = {
    isNormalUser = true;
    initialPassword = "12345";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];
}
