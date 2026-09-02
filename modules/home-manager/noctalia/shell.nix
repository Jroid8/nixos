{ lib, config, ... }:
let
  cfg = config.custom.noctalia;
in
{
  config = lib.mkIf cfg.enable {
    programs.noctalia.settings.shell = {
      avatar_path = "${config.home.homeDirectory}/Pictures/Logo.png";
      clipboard_enabled = false;
      panel = {
        shadow = false;
        transparency_mode = "soft";
      };
      session.actions =
        builtins.map
          ({ action, shortcut }: {
            inherit action shortcut;
            countdown_seconds = 0.0;
            enabled = true;
            variant = "default";
          })
          [
            {
              action = "logout";
              shortcut = "1";
            }
            {
              action = "reboot";
              shortcut = "2";
            }
            {
              action = "shutdown";
              shortcut = "3";
            }
          ];
    };
  };
}
