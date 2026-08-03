{
  pkgs,
  config,
  lib,
  ...
}:
let
  rofi = lib.getExe config.custom-pkgs.rofi;
in
{
  programs.yazi.keymap = {
    mgr = {
      prepend_keymap = [
        {
          on = [ "M" ];
          run = "plugin mount";
        }
      ];
      append_keymap = [
        {
          on = [
            "!"
            "s"
          ];
          run = ''shell "$SHELL" --block'';
          desc = "Open $SHELL here";
        }
        {
          on = [ "<A-d>" ];
          run = "shell -- ${pkgs.dragon-drop} -T %s";
          desc = "drag and drop selected";
        }
        {
          on = [ "<A-D>" ];
          run = "shell -- ${pkgs.dragon-drop} -T -A %s";
          desc = "drag and drop all at once";
        }
        {
          on = [
            "!"
            "r"
          ];
          run = ''shell -- ${rofi} -config filebrowser -show filebrowser -filebrowser-command "ya emit reveal" -filebrowser-directory "$(pwd)"'';
          desc = "Grid view";
        }
      ];
    };
    input.append_keymap = [
      {
        on = [ "<Esc>" ];
        run = "close";
        desc = "Cancel input";
      }
      {
        on = [
          "j"
          "k"
        ];
        run = "close";
        desc = "Cancel input";
      }
    ];
  };
}
