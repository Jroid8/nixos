{ config, lib, ... }: let cfg = config.custom.direnv; in {
  options = {
    custom.direnv.enable = lib.mkEnableOption "customized direnv";
  };
  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
  };
}
