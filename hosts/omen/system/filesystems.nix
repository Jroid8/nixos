{ config, ... }: {
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
    "/mnt/windows" = {
      device = "/dev/disk/by-uuid/CCB45F53B45F3EE0";
      fsType = "ntfs";
      options = [
        "uid=${builtins.toString config.users.users.jroid.uid}"
        "gid=${builtins.toString config.users.groups.jroid.gid}"
      ];
    };
  };
  boot.tmp.useZram = true;
}
