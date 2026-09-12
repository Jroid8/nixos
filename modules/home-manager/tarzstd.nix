{
  lib,
  config,
  mypkgs,
  ...
}:
let
  cfg = config.programs.tarzstd;
in
{
  options = {
    programs.tarzstd = {
      enable = lib.mkEnableOption "tarzstd scripts";
      compressorPackage = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
      };
      estimatorPackage = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.mps.compressorPackage = mypkgs.tarzstd;
    programs.mps.estimatorPackage = mypkgs.tarzstdtest;
    home.packages = [
      cfg.compressorPackage
      cfg.estimatorPackage
    ];
  };
}
