{
  config,
  lib,
  pkgs,
  dag,
  ...
}:
let
  cfg = config.custom.rainbow-delimiters;
in
{
  options = {
    custom.rainbow-delimiters = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.start = [ pkgs.vimPlugins.rainbow-delimiters-nvim ];
    initLuaDag.rainbow-delimiters = dag.entryAfter [ "rainbowcol-highlights" ] /* lua */ ''
      vim.g.rainbow_delimiters = {
        highlight = rainbow_hl_groups,
      }
    '';
  };
}
