{ config, lib, ... }:
let
  cfg = config.custom.noctalia;
in
{
  config = lib.mkIf cfg.enable {
    programs.noctalia.settings = {
      theme = {
        source = "wallpaper";
        wallpaper_scheme = "faithful";
        templates = {
          builtin_ids = [
            "gtk3"
            "gtk4"
            "hyprland"
            "kcolorscheme"
            "qt"
          ];
          community_ids = [
            "rofi"
            "zathura"
            "hyprtoolkit"
            "yazi"
          ];
        };
      };

      wallpaper = {
        directory = "${config.home.homeDirectory}/Pictures/Wallpapers";
        transition_on_startup = true;
        automation = {
          enabled = true;
          interval_seconds = 3600;
        };
      };
    };
  };
}
