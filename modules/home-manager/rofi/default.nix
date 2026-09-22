{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.rofi;
in
{
  options = {
    custom.rofi = {
      enable = lib.mkEnableOption "customized rofi";
      finalPackage = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    custom.rofi.finalPackage = pkgs.rofi.override (_: {
      plugins = [ pkgs.rofi-calc ];
      theme = ./mytheme.rasi;
    });
    home.packages = [
      pkgs.nerd-fonts.jetbrains-mono
      cfg.finalPackage
    ];
  };
}
