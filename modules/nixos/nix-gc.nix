{ lib, config, ... }: {
  options = {
    custom.nix-gc = {
      enable = lib.mkEnableOption "customized nix-gc";
    };
  };
  config = lib.mkIf config.custom.nix-gc.enable {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
