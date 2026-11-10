{
  config,
  lib,
  pkgs,
  dag,
  ...
}:
let
  cfg = config.custom.lualine;
in
{
  options = {
    custom.lualine = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.start = [ pkgs.vimPlugins.lualine-nvim ];
    initLuaDag.lualine-setup = dag.entryAfter [ "colorscheme" ] /* lua */ ''
      require("lualine").setup({
        options = {
          component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            {
              "filetype",
              colored = true,
              icon_only = true,
            },
            {
              "filename",
              symbols = {
                modified = " ",
                readonly = " "
              },
            }
          },
          lualine_c = {
            {
              "diff",
              colored = false,
              symbols = {
                added = "+",
                modified = "~",
                removed = "-",
              },
            }
          },
          lualine_x = {
            {
              function()
                local buf_ft = vim.bo.filetype
                local excluded_fts = { "toggleterm", "neo-tree" }
                if vim.tbl_contains(excluded_fts, buf_ft) then
                  return ""
                end
                local clients = vim.lsp.get_clients({
                  bufnr = vim.api.nvim_get_current_buf()
                })
                if vim.tbl_isempty(clients) then
                  return "No Active LSP"
                end
                return table.concat(
                  vim.tbl_map(function(c) return c.name end, clients),
                  ", "
                )
              end,
              icon = " ",
            },
            {
              "diagnostics",
              sources = { "nvim_lsp", "nvim_diagnostic", "vim_lsp", "coc" },
              symbols = {
                error = "󰅙  ",
                warn = "  ",
                info = "  ",
                hint = "󰌵 ",
              },
              colored = true,
              update_in_insert = false,
              always_visible = false,
              diagnostics_color = {
                color_error = { fg = "red" },
                color_warn = { fg = "yellow" },
                color_info = { fg = "blue" }
              },
            }
          },
          lualine_y = { "branch" },
          lualine_z = {
            "progress",
            "location",
            {
              "fileformat",
              color = { fg = "black" },
              symbols = {
                unix = "",
                dos = "",
                mac = ""
              }
            },
          },
        }
      })
    '';
  };
}
