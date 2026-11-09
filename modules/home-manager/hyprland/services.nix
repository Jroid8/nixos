{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.custom.hyprland;
  brightnessctl = lib.getExe pkgs.brightnessctl;
in
{
  config = lib.mkIf cfg.enable {
    services = {
      hyprpolkitagent.enable = true;
      hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "hyprlock";
          };
          listener = [
            {
              timeout = 60*12;
              on-timeout = "${brightnessctl} -n1 -e9 s 25%-";
              on-resume = "${brightnessctl} -e9 s 25%+";
            }
            {
              timeout = 60*15;
              on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'";
              on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
            }
            {
              timeout = 60*20;
              on-timeout = "hyprlock";
            }
            {
              timeout = 60*30;
              on-timeout = "systemctl suspend";
            }
          ];
        };
      };
      hyprsunset = {
        enable = true;
        settings = {
          profile = [
            {
              time = "5:00";
              identity = true;
            }
            {
              time = "21:20";
              temperature = 4000;
            }
            {
              time = "22:00";
              temperature = 3300;
            }
            {
              time = "22:40";
              temperature = 2500;
            }
            {
              time = "23:20";
              temperature = 2000;
            }
            {
              time = "00:00";
              temperature = 1800;
            }
          ];
        };
      };
    };
  };
}
