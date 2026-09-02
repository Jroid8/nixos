{
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.nvf;
  inherit (inputs.nvf.lib.nvim) dag;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      extraLuaFiles = [
        ./terminal.lua
        ./autosave.lua
        ./project.lua
      ];
      luaConfigRC = {
        theme = dag.entryBefore [ "pluginConfigs" "lazyConfigs" ] /* lua */ ''
          require("nightfox").setup({
            options = {
              transparent = true,
              terminal_colors = false,
            },
          })
          vim.cmd([[colorscheme carbonfox]])
        '';
      };
    };
  };
}
