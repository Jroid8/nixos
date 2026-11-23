{
  lib,
  config,
  pkgs,
  dag,
  ...
}:
let
  cfg = config.custom.oil;
in
{
  options = {
    custom.oil = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    plugins.start = with pkgs.vimPlugins; [
      oil-nvim
      nvim-web-devicons
    ];
    initLuaDag.oil-setup = dag.entryAnywhere /* lua */ ''
      require("oil").setup({
        skip_confirm_for_simple_edits = true,
        watch_for_changes = true,
      })
    '';
  };
}
