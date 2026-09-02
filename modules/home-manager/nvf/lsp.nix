{ lib, config, ... }:
let
  cfg = config.custom.nvf;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      diagnostics = {
        config = {
          underline = true;
          virtual_text = true;
          signs.text = lib.generators.mkLuaInline ''
            {
            	[vim.diagnostic.severity.ERROR] = "󰅚 ",
              [vim.diagnostic.severity.WARN] = "󰀪 ",
              [vim.diagnostic.severity.INFO] = "󰋽 ",
              [vim.diagnostic.severity.HINT] = "󰌶 ",
            }
          '';
          jump = {
            float = true;
          };
          float = {
            border = "single";
          };
        };
      };
      lsp = {
        enable = true;
        mappings = {
          hover = "K";
          listImplementations = "gri";
          listReferences = "grr";
          nextDiagnostic = "]d";
          previousDiagnostic = "[d";
          openDiagnosticFloat = "grd";
        };
        nvim-docs-view.enable = true;
        otter-nvim.enable = true;
      };
    };
  };
}
