{ config, lib, ... }:
let
  cfg = config.custom.noctalia;
in
{
  options = {
    custom.noctalia = {
      enable = lib.mkEnableOption "customized noctalia";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings = {
        systemd.enable = true;
        desktop_widgets.enabled = false;
        idle.pre_action_fade_seconds = 0;
        lockscreen.enabled = false;
        lockscreen_widgets.enabled = false;
        osd.kinds.media = false;
        plugins.enabled = [ "noctalia/timer" ];
        weather.refresh_minutes = 60 * 4;
      };
    };
  };
}
