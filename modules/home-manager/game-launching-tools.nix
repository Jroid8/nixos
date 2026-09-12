{
  lib,
  mypkgs,
  config,
  ...
}:
let
  cfg = config.programs.game-launching-tools;
in
{
  options = {
    programs.game-launching-tools = {
      enable = lib.mkEnableOption "jroid's game launching tools";
      gametimePackage = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
      };
      gameSelectorPackage = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.game-launching-tools.gametimePackage = mypkgs.gametime;
    programs.game-launching-tools.gameSelectorPackage = mypkgs.game-selector;
    home.packages = [ cfg.gametimePackage cfg.gameSelectorPackage ];
  };
}
