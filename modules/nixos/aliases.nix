{ config, lib, ... }: {
  options = {
    custom.aliases = {
      enable = lib.mkEnableOption "custom aliases";
    };
  };
  config = lib.mkIf config.custom.aliases.enable {
    environment.shellAliases = import ../../lib/shell-aliases.nix;
  };
}
