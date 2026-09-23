{
  config,
  pkgs,
  lib,
  ...
}:
let cfg = config.custom.git; in {
  options = {
    custom.kitty.enable = lib.mkEnableOption "customized kitty";
  };
  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      enableGitIntegration = true;
      font = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
        size = 11;
      };
      settings = {
        background_opacity = 0.85;
      };
    };
  };
}
