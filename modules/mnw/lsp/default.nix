{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.lsp;
in
{
  options = {
    lsp = {
      ty = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      fish_lsp = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      tinymist = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      nil = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      glsl_analyzer = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      vscode_langservers = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };

  config = {
    plugins.start = [ pkgs.vimPlugins.nvim-lspconfig ];

    extraBinPath =
      (lib.optional cfg.ty pkgs.ty)
      ++ (lib.optional cfg.fish_lsp pkgs.fish-lsp)
      ++ (lib.optional cfg.tinymist pkgs.tinymist)
      ++ (lib.optional cfg.nil pkgs.nil)
      ++ (lib.optional cfg.glsl_analyzer pkgs.glsl_analyzer)
      ++ (lib.optional cfg.vscode_langservers pkgs.vscode-langservers-extracted);

    initLua = /* lua */ ''
      vim.lsp.enable({${
        (lib.optional cfg.ty "ty")
        ++ (lib.optional cfg.fish_lsp "fish_lsp")
        ++ (lib.optional cfg.tinymist "tinymist")
        ++ (lib.optional cfg.nil "nil_ls")
        ++ (lib.optional cfg.clangd "clangd")
        ++ (lib.optional cfg.glsl_analyzer "glsl_analyzer")
        ++ (lib.optionals cfg.vscode_langservers [
          "html"
          "cssls"
          "jsonls"
        ])
        |> builtins.map (ls: "\"${ls}\"")
        |> lib.join ","
      }})
    '';
  };
}
