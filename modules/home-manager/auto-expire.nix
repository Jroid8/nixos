{ lib, config, ... }:
let
  cfg = config.custom.autoExpire;
in
{
  options = {
    custom.autoExpire.enable = lib.mkEnableOption "customized autoExpire";
  };
  config = lib.mkIf cfg.enable {
    services.home-manager.autoExpire = {
      enable = true;
      frequency = "weekly";
      store = {
        cleanup = true;
        options = "--delete-older-than 7d";
      };
      timestamp = "-7 days";
    };
  };
}
