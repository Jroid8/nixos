{ lib, config, ... }:
let
  cfg = config.custom.term-run;
in
{
  options = {
    custom.term-run = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    custom.toggleterm.enable = true;
    luaFiles = [ ./term-run.lua ];
  };
}
