{ config, lib, ... }:
let
  cfg = config.custom.openssh;
in
{
  options = {
    custom.openssh = {
      enable = lib.mkEnableOption "Openssh without password login";
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };
}
