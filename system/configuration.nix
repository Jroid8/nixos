{ pkgs, inputs, ... }:
{
  imports = [
    ./doas.nix
    ./greet.nix
    ./packages.nix
    ./prime.nix
    ./programs.nix
    ./services
    "${inputs.hardware}/common/cpu/intel/comet-lake"
    inputs.hardware.nixosModules.common-pc
    inputs.hardware.nixosModules.common-pc-ssd
  ];

  system.stateVersion = "26.05";

  # Kernel
  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "vmd"
      "xhci_pci"
      "thunderbolt"
      "usb_storage"
      "sd_mod"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "amd_pstate=active" ];
    kernelModules = [ "kvm-intel" ];
  };

  # Firmwares
  hardware.firmware = with pkgs; [
    linux-firmware
    sof-firmware
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/093572c0-81dc-40a9-b7b4-1cc86173d2d2";
      fsType = "btrfs";
      options = [
        "subvol=root"
        "compress=zstd"
      ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/093572c0-81dc-40a9-b7b4-1cc86173d2d2";
      fsType = "btrfs";
      options = [
        "subvol=nix"
        "compress=zstd"
        "noatime"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/025F-70BD";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };
  swapDevices = [ { device = "/dev/disk/by-uuid/ffd87ad8-cdd8-4c66-a6f4-8fc3afa63741"; } ];
  boot.tmp.useZram = true;

  # GRUB
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      device = "nodev";
    };
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Networking
  networking = {
    hostName = "omen";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Tehran";

  # Locale
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "fa_IR/UTF-8" ];
  };

  # Nix
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
    cudaCapabilities = [
      "8.7"
      "8.6"
      "8.0"
    ];
    cudaForwardCompat = true;
    cudaSupport = true;
  };

  # Users
  users = {
    users.jroid = {
      isNormalUser = true;
      initialPassword = "12345";
      group = "jroid";
      extraGroups = [ "wheel" ];
      shell = pkgs.fish;
    };
    groups.jroid = { };
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];
}
