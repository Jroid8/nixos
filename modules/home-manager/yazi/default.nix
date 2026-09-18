{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.yazi;
in
{
  options = {
    custom.yazi = {
      enable = lib.mkEnableOption "customized yazi";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      plugins = {
        inherit (pkgs.yaziPlugins) mount;
      };
    };
  };
}
