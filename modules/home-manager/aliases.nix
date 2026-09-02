{ config, lib, ... }:
let
  cfg = config.custom.aliases;
in
{
  options = {
    custom.aliases.enable = lib.mkEnableOption "custom aliases";
  };
  config = lib.mkIf cfg.enable {
    home.shellAliases = import ../../lib/shell-aliases.nix;
  };
}
