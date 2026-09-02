{ lib, config, ... }:
let
  cfg = config.custom.hyprland;
in
{
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.workspace_rule = {
      workspace = "name:A";
      default = true;
      monitor = "eDP-1";
    };
  };
}
