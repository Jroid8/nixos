{pkgs, lib, ...}: {
  programs.nvf.settings.vim.languages = {
    enableTreesitter = true;
    enableFormat = true;

    assembly.enable = true;
    clang.enable = true;
    fish.enable = true;
    glsl.enable = true;
    html.enable = true;
    json.enable = true;
    lua.enable = true;
    python.enable = true;
		typescript.enable = true;

    css = {
      enable = true;
      format.enable = true;
    };
    make = {
      enable = true;
      extraDiagnostics.enable = true;
    };
    markdown = {
      enable = true;
      extensions.render-markdown-nvim.enable = true;
    };
    nix = {
      enable = true;
      extraDiagnostics.enable = true;
    };
    rust = {
      enable = true;
			lsp.enable = false;
      extensions.rustaceanvim = {
        enable = true;
        setupOpts = {
          tools = {
            enable_clippy = false;
            hover_actions = {
              replace_builtin_hover = false;
            };
          };
          server = {
            cmd = [ "${lib.getExe pkgs.rust-analyzer}" ];
            default_settings = {
              rust-analyzer = {
                diagnostics = {
                  disabled = [ "inactive-code" ];
                };
              };
            };
          };
        };
      };
    };
		typst = {
			enable = true;
			extensions.typst-preview-nvim.enable = true;
		};
  };
}
