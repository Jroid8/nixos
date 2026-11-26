{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.various-textobjs;
in
{
  options = {
    custom.various-textobjs = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.opt = [ pkgs.vimPlugins.nvim-various-textobjs ];
    lz-n = [{
      name = "nvim-various-textobjs";
      event = "DeferredUIEnter";
      after = lib.mkLuaInline /* lua */ ''
        function()
          require("various-textobjs").setup({ 
            keymaps = {
              useDefaults = true,
              disabledDefaults = { "r", "n", "." },
            }
          })
        end
      '';
    }];
  };
}
