{ lib, config, ... }:
let
  cfg = config.custom.term-buf;
in
{
  options = {
    custom.term-buf = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    luaFiles = [ ./term-buf.lua ];
  };
}
