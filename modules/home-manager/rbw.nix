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
    custom.rbw.enable = lib.mkEnableOptions "customized rbw";
  };
  config = lib.mkIf cfg.enable {
    programs.rbw = {
      enable = true;
      settings = {
        email = "jroid8@tutanota.com";
        pinentry = pkgs.pinentry-rofi.override (_: {
          rofi = config.custom-pkgs.rofi;
        });
      };
    };
  };
}
