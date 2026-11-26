{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.surround;
in
{
  options = {
    custom.surround = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.opt = [ pkgs.vimPlugins.nvim-surround ];
    lz-n = [
      {
        name = "nvim-surround";
        event = "DeferredUIEnter";
      }
    ];
  };
}
