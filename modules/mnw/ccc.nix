{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.ccc;
in
{
  options = {
    custom.ccc = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.opt = [ pkgs.vimPlugins.ccc-nvim ];
    lz-n = [
      {
        name = "ccc.nvim";
        keys = [
          {
            mode = "n";
            key = "<leader>jp";
            action = "<Cmd>CccPick<CR>";
            desc = "ccc pick";
          }
        ];
        cmd = [
          "CccPick"
          "CccConvert"
          "CccHighlighterEnable"
          "CccHighlighterToggle"
        ];
        after = lib.mkLuaInline /* lua */ ''
          function()
            local ccc = require("ccc")
            ccc.setup({
              inputs = {
                ccc.input.rgb,
                ccc.input.hsv,
                ccc.input.hsl,
              },
              output = {
                ccc.output.hex,
                ccc.output.css_rgb,
                ccc.output.css_rgba,
                ccc.output.css_hsl,
              },
            })
          end
        '';
      }
    ];
  };
}
