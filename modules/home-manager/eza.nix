{ lib, config, ... }:
let
  cfg = config.custom.eza;
in
{
  options = {
    custom.eza.enable = lib.mkEnableOption "customized eza";
  };
  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
      colors = "auto";
      icons = "auto";
      extraOptions = [ "--no-quotes" ];
    };
  };
}
