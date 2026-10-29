{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.custom.fzf-lua;
  keys = [
    {
      mode = "n";
      key = "<leader>fg";
      action = lib.mkLuaInline /* lua */ ''
        function() require("fzf-lua").live_grep() end
      '';
      desc = "fzf-lua live-grep";
    }
    {
      mode = "n";
      key = "<leader>fG";
      action = lib.mkLuaInline /* lua */ ''
        function() require("fzf-lua").grep() end
      '';
      desc = "fzf-lua grep";
    }
    {
      mode = [
        "n"
        "i"
        "t"
      ];
      key = "<A-f>";
      action = lib.mkLuaInline /* lua */ ''
        function() require("fzf-lua").files() end
      '';
      desc = "fzf-lua files";
    }
    {
      mode = [
        "n"
        "i"
        "t"
      ];
      key = "<A-b>";
      action = lib.mkLuaInline /* lua */ ''
        function() require("fzf-lua").buffers() end
      '';
      desc = "fzf-lua files";
    }
    {
      mode = "n";
      key = "<leader>fq";
      action = lib.mkLuaInline /* lua */ ''
        function() require("fzf-lua").quickfix() end
      '';
      desc = "fzf-lua quickfix list";
    }
    {
      mode = "n";
      key = "<leader>fs";
      action = lib.mkLuaInline /* lua */ ''
        function() require("fzf-lua").lsp_document_symbols() end
      '';
      desc = "fzf-lua document symbols";
    }
    {
      mode = "n";
      key = "<leader>fS";
      action = lib.mkLuaInline /* lua */ ''
        function() require("fzf-lua").lsp_workspace_symbols() end
      '';
      desc = "fzf-lua workspace symbols";
    }
    {
      mode = "n";
      key = "<leader>fd";
      action = lib.mkLuaInline /* lua */ ''
        function() require("fzf-lua").lsp_workspace_diagnostics() end
      '';
      desc = "fzf-lua workspace diagnostics";
    }
    {
      mode = "n";
      key = "<leader>fk";
      action = lib.mkLuaInline /* lua */ ''
        function() require("fzf-lua").keymaps() end
      '';
      desc = "fzf-lua keymaps";
    }
    {
      mode = "n";
      key = "gra";
      action = lib.mkLuaInline /* lua */ ''
        function() require("fzf-lua").lsp_code_actions() end
      '';
      desc = "fzf-lua lsp actions";
    }
  ];
in
{
  options = {
    custom.fzf-lua = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    extraBinPath = with pkgs; [
      fzf
      ripgrep
      fd
      bat
    ];
    plugins = {
      start = with pkgs.vimPlugins; [
        nvim-web-devicons
      ];
      opt = with pkgs.vimPlugins; [
        fzf-lua
      ];
    };
    initLua = /* lua */ ''
      vim.env.FZF_DEFAULT_OPTS = nil
    '';
    lz-n = [
      {
        name = "fzf-lua";
        inherit keys;
        cmd = "FzfLua";
        after = lib.mkLuaInline /* lua */ ''
          function()
            local fzf = require("fzf-lua")
            fzf.setup {
              fzf_colors = true,
              file_icon_padding = ' ',
              winopts = {
                backdrop = 100,
              },
              keymap = {
                builtin = {
                  ["<A-p>"] = "toggle-preview",
                  ["<A-d>"] = "preview-page-down",
                  ["<A-u>"] = "preview-page-up",
                },
              },
            }
            fzf.register_ui_select()
          end
        '';
      }
    ];
  };
}
