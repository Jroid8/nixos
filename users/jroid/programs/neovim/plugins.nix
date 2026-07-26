{ pkgs, lib, ... }:
let
  inherit (lib.generators) mkLuaInline;
in
{
  programs.nvf.settings.vim = {
    autopairs.nvim-autopairs.enable = true;
    ui.colorful-menu-nvim.enable = true;
    # ui.ui2.enable = true;
    utility.ccc.enable = true;
    utility.grug-far-nvim.enable = true;
    utility.mkdir.enable = true;
    utility.nix-develop.enable = true;
    utility.oil-nvim.enable = true;
    visuals.blink-indent.enable = true;
    visuals.fidget-nvim.enable = true;
    visuals.nvim-web-devicons.enable = true;
    comments.comment-nvim = {
      enable = true;
      mappings = {
        toggleCurrentBlock = "||";
        toggleCurrentLine = "\\\\";
        toggleOpLeaderBlock = "|";
        toggleOpLeaderLine = "\\";
        toggleSelectedBlock = "|";
        toggleSelectedLine = "\\";
      };
    };
    filetree.neo-tree = {
      enable = true;
      setupOpts = {
        filesystem.hijack_netrw_behavior = "disabled";
        git_status_async = true;
        log_level = "warn";
      };
    };
    notes.neorg = {
      enable = true;
      treesitter.enable = true;
      setupOpts = {
        "core.defaults".enable = true;
        "core.concealer" = { };
        "core.keybinds" = {
          config = {
            default_keybinds = false;
          };
        };
        "core.highlights" = { };
        "core.export" = { };
        "core.export.markdown" = { };
      };
    };
    statusline.lualine.enable = true;
    utility.surround = {
      enable = true;
      setupOpts.keymaps = {
        insert = "<C-g>s";
        insert_line = "<C-g>S";
        normal = "ys";
        normal_cur = "yss";
        normal_line = "yS";
        normal_cur_line = "ySS";
        visual = "S";
        visual_line = "gS";
        delete = "ds";
        change = "cs";
        change_line = "cS";
      };
    };
    terminal.toggleterm = {
      enable = true;
			mappings.open = "<C-;>";
      setupOpts = {
        size = mkLuaInline /* lua */ ''
          function(term)
          	if term.direction == "horizontal" then
          		return vim.api.nvim_win_get_height(0) * 0.7
          	end
          	if term.direction == "vertical" then
          		return vim.api.nvim_win_get_width(0) * 0.7
          	end
          end
        '';
      };
    };
    visuals.rainbow-delimiters = {
      enable = true;
      setupOpts.highlight = [
        "rainbowcol0"
        "rainbowcol1"
        "rainbowcol2"
        "rainbowcol3"
        "rainbowcol4"
        "rainbowcol5"
      ];
    };
    extraPlugins = with pkgs.vimPlugins; {
      ron = {
        package = ron-vim;
      };
      nvim-bqf = {
        package = nvim-bqf;
      };
      nightfox = {
        package = nightfox-nvim;
      };
      various-textobjs = {
        package = nvim-various-textobjs;
        setup = /* lua */ ''
          require("various-textobjs").setup({ 
          	keymaps = {
          		useDefaults = true,
          		disabledDefaults = { "r", "n", "." },
          	}
          })
        '';
      };
      telescope-symbols = {
        package = telescope-symbols-nvim;
      };
    };
  };
}
