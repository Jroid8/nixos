{
  config,
  pkgs,
  lib,
  ...
}:
let cfg = config.custom.git; in {
  options = {
    custom.git.enable = lib.mkEnableOption "customized kitty";
  };
  config = lib.mkIf cfg.enable {
    terminal-emulator = pkgs.kitty;
    home.packages = [ config.terminal-emulator ];
    programs.kitty = {
      enable = true;
      enableGitIntegration = true;
      font = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
        size = 11;
      };
      shellIntegration.enableFishIntegration = true;
      settings = {
        background_opacity = 0.85;
      };
    };
  };
}
