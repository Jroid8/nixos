{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.doas;
in
{
  options = {
    custom.doas = {
      enable = lib.mkEnableOption "customized doas";
    };
  };
  config = lib.mkIf cfg.enable {
    security.doas = {
      enable = true;
      extraRules = [
        {
          users = [ "root" ];
          noPass = true;
        }
        {
          groups = [ "wheel" ];
          persist = true;
        }
      ];
    };

    security.sudo.enable = false;
    environment.systemPackages = [ pkgs.doas-sudo-shim ];
  };
}
