{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.carbonfox;
in
{
  options = {
    custom.carbonfox.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    initLua = /* lua */ ''
      require("nightfox").setup({
        options = {
          transparent = true,
          terminal_colors = false,
        },
      })
      vim.cmd("colorscheme carbonfox")
    '';
    plugins.start = [ pkgs.vimPlugins.nightfox-nvim ];
  };
}
