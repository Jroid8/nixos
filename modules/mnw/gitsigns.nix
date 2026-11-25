{
  config,
  lib,
  dag,
  pkgs,
  ...
}:
let
  cfg = config.custom.gitsigns;
in
{
  options = {
    custom.gitsigns = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.start = [ pkgs.vimPlugins.gitsigns-nvim ];
    initLuaDag.gitsigns-setup = dag.entryAnywhere /* lua */ ''
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")
          local function map(mode, l, r, desc, opts)
            opts = opts or {}
            opts.buffer = bufnr
            opts.desc = desc
            vim.keymap.set(mode, l, r, opts)
          end

          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({"]c", bang = true})
            else
              gitsigns.nav_hunk("next")
            end
          end, "next git hunk")
          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({"[c", bang = true})
            else
              gitsigns.nav_hunk("prev")
            end
          end, "previous git hunk")

          map("n", "<leader>gs", gitsigns.stage_hunk, "git stage hunk")
          map("n", "<leader>gr", gitsigns.reset_hunk, "git reset hunk")
          map("v", "<leader>gs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, "git stage hunk")
          map("v", "<leader>gr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, "git reset hunk")
          map("n", "<leader>gS", gitsigns.stage_buffer, "git stage buffer")
          map("n", "<leader>gR", gitsigns.reset_buffer, "git reset buffer")
          map("n", "<leader>gp", gitsigns.preview_hunk, "git preview hunk")
          map("n", "<leader>gi", gitsigns.preview_hunk_inline, "git hunk inline")
          map("n", "<leader>gb", function()
            gitsigns.blame_line({ full = true })
          end, "git blame line")
          map("n", "<leader>gd", gitsigns.diffthis, "vimdiff against git index")
          map("n", "<leader>gD", function()
            gitsigns.diffthis("~1")
          end, "vimdiff against last git commit")
          map("n", "<leader>gQ", function() gitsigns.setqflist("all") end, "populate the quickfix list with git hunks across the repo")
          map("n", "<leader>gq", gitsigns.setqflist, "populate the quickfix list with git hunks in this file")
          map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "git toggle current line blame")
          map("n", "<leader>tw", gitsigns.toggle_word_diff, "git toggle word diff")
          map({"o", "x"}, "ih", gitsigns.select_hunk, "hunk text object")
        end
      })
    '';
  };
}
