{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.custom.git;
in
{
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
    xdg.terminal-exec = {
      enable = true;
      settings.default = [ "kitty.desktop" ];
    };
    home = {
      sessionVariables.TERM = lib.getExe pkgs.kitty;
      # Workaround until xdg-utils 1.3 comes to stable
      packages = [
        (pkgs.runCommand "xterm-kitty-alias" { } ''
          mkdir -p $out/bin
          ln -s ${lib.getExe pkgs.kitty} $out/bin/xterm-kitty
        '')
      ];
    };
  };
}
