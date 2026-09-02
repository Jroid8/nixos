{ config, lib, ... }:
let
  cfg = config.custom.noctalia;
in
{
  config = lib.mkIf cfg.enable {
    programs.noctalia.settings.widget = {
      battery.hide_when_plugged = true;
      cpu.glyph = "cpu";
      media = {
        hide_when_no_media = true;
        max_length = 400;
      };
      network_rx.interface = "wlo1";
      privacy.hide_inactive = true;
      ram.glyph = "database";
      workspaces.display = "name";
      date.format = "{:%a %d %b %T}";
    };
  };
}
