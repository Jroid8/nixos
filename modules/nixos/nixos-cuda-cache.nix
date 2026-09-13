{ config, lib, ... }:
let
  cfg = config.custom.nixos-cuda-cache;
in
{
  options = {
    custom.nixos-cuda-cache = {
      enable = lib.mkEnableOption "nixos-cuda.org cache";
    };
  };
  config = lib.mkIf cfg.enable {
    nix.settings = {
      substituters = [
        "https://cache.nixos-cuda.org"
      ];
      trusted-public-keys = [
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      ];
    };
  };
}
