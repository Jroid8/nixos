{
  pkgs,
  config,
  lib,
  mypkgs,
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
    custom.rofi.finalPackage = mypkgs.themed-rofi;
    home.packages = [
      pkgs.nerd-fonts.jetbrains-mono
      cfg.finalPackage
    ];
  };
}
