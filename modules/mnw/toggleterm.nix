{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.toggleterm;
  open_mapping = "<C-;>";
in
{
  options = {
    custom.toggleterm = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.opt = [ pkgs.vimPlugins.toggleterm-nvim ];
    lz-n = [
      {
        name = "toggleterm.nvim";
        keys = [
          {
            mode = [
              "n"
              "i"
              "t"
            ];
            key = open_mapping;
            action = "<Cmd>execute v:count . \"ToggleTerm\"<CR>";
            desc = "Toggle terminal";
          }
        ];
        cmd = [
          "ToggleTerm"
          "TermExec"
        ];
        after = lib.mkLuaInline /* lua */ ''
          function()
            require("toggleterm").setup()
          end
        '';
      }
    ];
  };
}
