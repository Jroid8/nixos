{ lib, config, ... }:
let
  cfg = config.custom.hyprland;
in
{
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.window_rule = [
      {
        name = "suppress-maximize-events";
        match = {
          class = ".*";
        };
        suppress_event = "maximize";
      }
      {
        name = "fix-xwayland-drags";
        match = {
          class = "^$";
          title = "^$";
          xwayland = true;
          float = true;
          fullscreen = false;
          pin = false;
        };
        no_focus = true;
      }
      {
        name = "kitty float";
        match = {
          class = "kitty-popup";
        };
        float = true;
        center = true;
        tile = false;
        size = [
          "(monitor_w*0.6)"
          "(monitor_h*0.75)"
        ];
      }
      {
        name = "mpv float";
        match = {
          class = "mpv-float";
        };
        float = true;
        tile = false;
      }
    ];
  };
}
