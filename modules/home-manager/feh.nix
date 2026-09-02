{ lib, config, ... }:
let
  cfg = config.custom.feh;
in
{
  options = {
    custom.feh.enable = lib.mkEnableOption "customized feh";
  };
  config = lib.mkIf cfg.enable {
    programs.feh = {
      enable = true;
      keybindings = {
        scroll_up = "k";
        scroll_down = "j";
        scroll_left = "h";
        scroll_right = "l";
        zoom_in = "u";
        zoom_out = "d";
        zoom_default = "C-z";
        zoom_fit = "z";

        next_img = "i";
        prev_img = "o";

        delete = "D";

        menu_parent = [
          "h"
          "Left"
        ];
        menu_child = [
          "l"
          "Right"
        ];
        menu_down = [
          "j"
          "Down"
        ];
        menu_up = [
          "k"
          "Up"
        ];
        menu_select = [
          "space"
          "Return"
        ];
      };
    };
  };
}
