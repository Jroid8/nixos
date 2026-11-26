{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.neorg;
  lua-utils = pkgs.fetchFromGitHub {
    owner = "nvim-neorg";
    repo = "lua-utils.nvim";
    rev = "v1.0.2";
    hash = "sha256-9ildzQEMkXKZ3LHq+khGFgRQFxlIXQclQ7QU3fcU1C4=";
    name = "lua-utils.nvim";
  };
  pathlib = pkgs.fetchFromGitHub {
    owner = "pysan3";
    repo = "pathlib.nvim";
    rev = "v2.2.3";
    hash = "sha256-YhCJeNKlcjgg3q51UWFhuIEPzNueC8YTpeuPPJDndvw=";
    name = "pathlib.nvim";
  };
in
{
  options = {
    custom.neorg = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.opt = [
      lua-utils
      pathlib
      pkgs.vimPlugins.nvim-nio
      pkgs.vimPlugins.neorg
    ];
    lz-n = [
      { name = "lua-utils.nvim"; }
      { name = "pathlib.nvim"; }
      { name = "nvim-nio"; }
      {
        name = "neorg";
        ft = "norg";
        after = lib.mkLuaInline /* lua */ ''
          function()
            require("neorg").setup({
              load = {
                ["core.defaults"] = {
                  enable = true,
                },
                ["core.concealer"] = {},
                ["core.keybinds"] = {
                  config = {
                    default_keybinds = false,
                  }
                },
                ["core.highlights"] = { },
                ["core.export"] = { },
                ["core.export.markdown"] = { },
                ["core.esupports.indent"] = { },
              }
            })
          end
        '';
      }
    ];
  };
}
