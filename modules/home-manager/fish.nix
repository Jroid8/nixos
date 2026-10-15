{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.custom.fish;
in
{
  options = {
    custom.fish.enable = lib.mkEnableOption "customized fish";
  };
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.fish = {
        enable = true;
        shellAbbrs = {
          dr.expansion = "dragon-drop";
          curlo.expansion = "curl -LO";
          nohp = {
            expansion = "nohup % &> /dev/null";
            position = "command";
            setCursor = true;
          };
        };
        interactiveShellInit = /* fish */ ''
          ${lib.getExe pkgs.starship} init fish | source
        '';
        shellInit = /* fish */ ''
          function fish_user_key_bindings
          	fish_default_key_bindings -M insert
          	fish_vi_key_bindings --no-erase insert
          	bind -M insert jf -m default backward-char force-repaint
          end
        '';
        functions = {
          mkcdir = {
            argumentNames = [ "directory name" ];
            description = "make directory and cd to it";
            body = "mkdir $argv[1] && cd $argv[1]";
          };
          fish_greeting = "";
        };
      };
      home.shell.enableFishIntegration = true;
    })
    (lib.mkIf (cfg.enable && config.programs.zathura.enable) {
      programs.fish.shellAbbrs.za.expansion = "zathura";
    })
  ];
}
