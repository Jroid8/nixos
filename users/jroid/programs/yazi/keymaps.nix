{
  programs.yazi.keymap = {
    mgr = {
      prepend_keymap = [
        {
          on = [ "m" ];
          run = "plugin bookmarks save";
          desc = "Save current position as a bookmark";
        }
        {
          on = [ "'" ];
          run = "plugin bookmarks jump";
          desc = "Jump to a bookmark";
        }
        {
						/*nixfmt:disable*/
            on = [ "b" "d" ];
						/*nixfmt:enable*/
          run = "plugin bookmarks delete";
          desc = "Delete a bookmark";
        }
        {
						/*nixfmt:disable*/
            on = [ "b" "D" ];
						/*nixfmt:enable*/
          run = "plugin bookmarks delete_all";
          desc = "Delete all bookmarks";
        }
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
          run = "shell -- dragon-drop -T %s";
          desc = "drag and drop selected";
        }
        {
          on = [ "<A-D>" ];
          run = "shell -- dragon-drop -T -A %s";
          desc = "drag and drop all at once";
        }
        {
          on = [ "<A-g>" ];
          run = ''shell -- rofi -config filebrowser -show filebrowser -filebrowser-command "ya emit reveal" -filebrowser-directory "$(pwd)"'';
          desc = "Grid view";
        }
        {
						/*nixfmt:disable*/
            on = [ "g" "t" ];
						/*nixfmt:enable*/
          run = "cd /dev/shm";
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
					/*nixfmt:disable*/
          on = [ "j" "k" ];
					/*nixfmt:enable*/
        run = "close";
        desc = "Cancel input";
      }
    ];
  };
}
