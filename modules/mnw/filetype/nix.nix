{
  config,
  lib,
  dag,
  ...
}:
let
  cfg = config.custom.nix-expandtab;
in
{
  options = {
    custom.nix-expandtab = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    initLuaDag.nix-autocmd = dag.entryAnywhere /* lua */ ''
      vim.api.nvim_create_autocmd({"FileType"}, {
        pattern = {"nix"},
        callback = function()
          vim.bo.tabstop = 2
          vim.bo.shiftwidth = 2
          vim.bo.expandtab = true
        end
      })
    '';
  };
}
