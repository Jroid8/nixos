{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.mkdir;
in
{
  options = {
    custom.mkdir = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.start = [ pkgs.vimPlugins.mkdir-nvim ];
  };
}
