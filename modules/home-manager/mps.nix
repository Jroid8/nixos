{
  lib,
  pkgs,
  mypkgs,
  config,
  ...
}:
let
  cfg = config.programs.mps;
in
{
  options = {
    programs.mps = {
      enable = lib.mkEnableOption "mps, jroid's mpd services";
      dmenu = lib.mkPackageOption pkgs "dmenu program to use" { };
      finalPackage = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.mps.finalPackage = mypkgs.mps.override {
      inherit (cfg) dmenu;
    };
    home.packages = [ cfg.finalPackage ];
  };
}
