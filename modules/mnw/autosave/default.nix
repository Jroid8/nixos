{ lib, config, ... }:
let
  cfg = config.custom.autosave;
in
{
  options = {
    custom.autosave = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    luaFiles = [ ./autosave.lua ];
  };
}
