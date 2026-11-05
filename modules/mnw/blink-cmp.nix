{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.blink-cmp;
in
{
  options = {
    custom.blink-cmp = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.start = with pkgs.vimPlugins; [ blink-cmp ];
    initLua = /* lua */ ''
      require("blink.cmp").setup({
        cmdline = {
          keymap = {
            preset = "inherit"
          }
        },
        keymap = {
          preset = "none",
          ["<A-space>"] = {
            "show",
            "show_documentation",
            "hide_documentation",
          },
          ["<A-i>"] = {"select_next"},
          ["<A-o>"] = {"select_prev"},
          ["<A-b>"] = {
            "scroll_documentation_up",
            "fallback",
          },
          ["<A-f>"] = {
            "scroll_documentation_down",
            "fallback",
          },
          ["<A-n>"] = {
            "snippet_forward",
            "fallback",
          },
          ["<A-CR>"] = {"select_and_accept"},
        },
        appearance = {
          use_nvim_cmp_as_default = true
        },
        sources = {
          default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
          },
        },
        completion = {
          keyword = {
            range = "full",
          },
        },
        fuzzy = {
          implementation = "rust",
          prebuilt_binaries = {
            download = false,
          },
        },
      })
    '';
  };
}
