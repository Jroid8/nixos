{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.rbw;
in
{
  options = {
    custom.rbw = {
      enable = lib.mkEnableOption "customized rbw";
      pinentry = lib.mkPackageOption pkgs "pinentry package to use" {
        default = [ "pinentry-gtk2" ];
      };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.rbw = {
      enable = true;
      settings = {
        email = "jroid8@tutanota.com";
        inherit (cfg) pinentry;
      };
    };
  };
}
