{ pkgs, ... }:
{
  imports = [
    ./doas.nix
    ./filesystems.nix
    ./greet.nix
    ./hardware.nix
    ./nix-settings.nix
    ./packages.nix
    ./programs.nix
    ./services
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
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      device = "nodev";
    };
  };

  # Networking
  networking = {
    hostName = "omen";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  # Locale
  time.timeZone = "Asia/Tehran";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "fa_IR/UTF-8" ];
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
    groups.jroid.gid = 1000;
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];
}
