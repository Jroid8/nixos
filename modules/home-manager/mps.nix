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
      dmenuCmd = lib.mkOption {
        type = lib.types.nonEmptyStr;
        default = lib.getExe pkgs.dmenu;
      };
      finalPackage = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.mps.finalPackage = mypkgs.mps.override {
      inherit (cfg) dmenuCmd;
    };
    home.packages = [ cfg.finalPackage ];
  };
}
