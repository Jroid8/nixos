{ config, lib, ... }:
let
  cfg = config.custom.noctalia;
in
{
  config = lib.mkIf cfg.enable {
    programs.noctalia.settings.widget = {
      cpu.glyph = "cpu";
      media = {
        hide_when_no_media = true;
        max_length = 400;
      };
      network_rx.interface = "wlo1";
      privacy.hide_inactive = true;
      ram.glyph = "database";
      workspaces.label_source = "name";
      date.format = "{:%a %d %b %T}";
      timer.type = "noctalia/timer:bar";
    };
  };
}
