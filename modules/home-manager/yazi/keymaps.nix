{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.yazi;
in
{
  config = lib.mkIf cfg.enable {
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
            on = [ "!" ];
            run = ''shell "$SHELL" --block'';
            desc = "Open $SHELL here";
          }
          {
            on = [ "<A-d>" ];
            run = "shell -- ${lib.getExe pkgs.dragon-drop} -T %s";
            desc = "drag and drop selected";
          }
          {
            on = [ "<A-D>" ];
            run = "shell -- ${lib.getExe pkgs.dragon-drop} -T -A %s";
            desc = "drag and drop all at once";
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
  };
}
