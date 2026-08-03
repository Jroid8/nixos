{
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
      options = [ "umask=0022" ];
    };
  };
  swapDevices = [ { device = "/dev/disk/by-uuid/ffd87ad8-cdd8-4c66-a6f4-8fc3afa63741"; } ];
  boot.tmp.useZram = true;
}
