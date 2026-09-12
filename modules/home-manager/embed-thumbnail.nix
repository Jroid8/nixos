{
  lib,
  mypkgs,
  config,
  ...
}:
let
  cfg = config.programs.embed-thumbnail;
in
{
  options = {
    programs.embed-thumbnail = {
      enable = lib.mkEnableOption "embed-thumbnail, my script to embed image into video as thumbnail";
      finalPackage = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.embed-thumbnail.finalPackage = mypkgs.embed-thumbnail;
    home.packages = [ cfg.finalPackage ];
  };
}
