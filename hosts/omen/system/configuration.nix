{ pkgs, ... }:
{
  imports = [
    ../../../modules/nixos/locale.nix
    ./filesystems.nix
    ./hardware.nix
		./packages.nix
		./programs.nix
    ./services.nix
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

  # GRUB
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 1;
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      device = "nodev";
    };
  };

  # Swap
  swapDevices = [ { device = "/dev/disk/by-uuid/ffd87ad8-cdd8-4c66-a6f4-8fc3afa63741"; } ];
  boot.zswap = {
    enable = true;
    maxPoolPercent = 50;
  };

  # Networking
  networking = {
    hostName = "omen";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  # Users
  users = {
    users.jroid = {
      uid = 1000;
      isNormalUser = true;
      initialPassword = "12345";
      group = "jroid";
      extraGroups = [ "wheel" ];
      shell = pkgs.fish;
    };
    groups.jroid.gid = 990;
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];
}
