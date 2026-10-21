{
  config,
  lib,
  ...
}:
let
  cfg = config.custom.hyprland;
in
{
  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = false;
        };

        background = [
          {
            path = "/home/jroid/Pictures/Wallpapers/hyprland-wall0.png";
          }
        ];

        animations = {
          enabled = true;
          bezier = "linear, 1, 1, 0, 0";
          animation = [
            "fade, 1, 5, bezier"
            "inputFieldDots, 1, 1.7, bezier"
            "inputFieldColors, 1, 0.8, bezier"
          ];
        };

        input-field = [
          {
            size = "20%, 8%";
            outline_thickness = 4;
            fail_text = "$PAMFAIL";
            dots_spacing = 0.3;
            inner_color = "rgba(0, 0, 0, 0.7)";
            fade_on_empty = false;
            font_color = "rgb(dddddd)";
            rounding = 15;

            outer_color = "rgba(0, 195, 255, 0.7) rgba(0, 0, 184, 0.7) 140deg";
            check_color = "rgba(0, 255, 255, 1.0) rgba(0, 50, 255, 1.0) 50deg";
            fail_color = "rgb(ffffff)";

            position = "0, -20";
            halign = "center";
            valign = "center";
          }
        ];

        label = [
          {
            text = "$TIME12";
            font_size = 90;

            position = "0, -50";
            halign = "center";
            valign = "top";
          }

          {
            text = "cmd[update:60000] date +\"%d %B %Y\"";
            font_size = 25;

            position = "-30, -200";
            halign = "center";
            valign = "top";
          }
        ];
      };
    };
  };
}
