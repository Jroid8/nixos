{
  config,
  lib,
  pkgs,
  dag,
  ...
}:
let
  cfg = config.custom.blink-indent;
in
{
  options = {
    custom.blink-indent = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.start = [ pkgs.vimPlugins.blink-indent ];
    initLuaDag.blink-indent = dag.entryAfter [ "colorscheme" "rainbowcol-highlights" ] /* lua */ ''
      require("blink.indent").setup({
        scope = {
          highlights = rainbow_hl_groups
        }
      })
    '';
  };
}
