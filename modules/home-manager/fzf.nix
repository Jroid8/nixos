{ lib, config, ... }:
let
  cfg = config.custom.fzf;
in
{
  options = {
    custom.fzf.enable = lib.mkEnableOption "customized fzf";
  };
  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      defaultOptions = [ "--color=hl:#00ff00,hl+:#00ff00" ];
    };
  };
}
