{ pkgs, lib, ... }:
let
  brightnessctl = "${lib.getExe pkgs.brightnessctl}";
in
{
  services = {
    hyprpolkitagent.enable = true;
    hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 900;
            on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'";
            on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })' && ${brightnessctl} -r";
          }
          {
            timeout = 830;
            on-timeout = "${brightnessctl} -n1 -e9 s 20%-";
            on-resume = "";
          }
          {
            timeout = 1200;
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
}
