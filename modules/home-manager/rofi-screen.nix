{
  lib,
  mypkgs,
  config,
  ...
}:
let
  cfg = config.programs.rofi-screen;
in
{
  options = {
    programs.rofi-screen = {
      enable = lib.mkEnableOption "rofi-screen";
      dmenuCmd = lib.mkOption {
        type = lib.types.nullOr lib.types.nonEmptyStr;
        default = null;
      };
      terminalEmulator = lib.mkOption {
        type = lib.types.nullOr lib.types.pathInStore;
        default = null;
      };
      finalPackage = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.rofi-screen.finalPackage = mypkgs.rofi-screen.override {
      inherit (cfg) dmenuCmd terminalEmulator;
    };
    home.packages = [ cfg.finalPackage ];
  };
}
