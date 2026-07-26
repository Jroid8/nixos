{ nvf, ... }:
let
  inherit (nvf.lib.nvim) dag;
in
{
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
}
