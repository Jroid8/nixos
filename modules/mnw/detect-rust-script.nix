{
  config,
  lib,
  dag,
  ...
}:
let
  cfg = config.custom.detect-rust-script;
in
{
  options = {
    custom.detect-rust-script = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    initLuaDag.rustscript-autocmd = dag.entryAnywhere /* lua */ ''
      vim.api.nvim_create_autocmd({"BufRead"}, {
        pattern = {"*"},
        callback = function()
          local l1 = vim.fn.getline(1)
            if l1:match("rust-script") then
            vim.bo.filetype = "rust"
          end
        end
      })
    '';
  };
}
