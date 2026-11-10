{
  config,
  lib,
  dag,
  ...
}:
let
  cfg = config.custom.fish-expandtab;
in
{
  options = {
    custom.fish-expandtab = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    initLuaDag.fish-autocmd = dag.entryAnywhere /* lua */ ''
      vim.api.nvim_create_autocmd({"FileType"}, {
        pattern = {"fish"},
        callback = function()
          vim.bo.tabstop = 4
          vim.bo.shiftwidth = 4
          vim.bo.expandtab = true
        end
      })
    '';
  };
}
