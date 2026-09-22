{ config, lib, ... }:
let
  cfg = config.custom.ollama;
in
{
  options = {
    custom.ollama = {
      enable = lib.mkEnableOption "customized ollama";
      acceleration = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      inherit (cfg) acceleration;
    };
    home.sessionVariables.OLLAMA_NOHISTORY = 1;
  };
}
