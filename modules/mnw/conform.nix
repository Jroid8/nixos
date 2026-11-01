{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.custom.conform;
in
{
  options = {
    custom.conform = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      black = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      stylua = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      nixfmt = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      typstyle = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.opt = [ pkgs.vimPlugins.conform-nvim ];
    extraBinPath =
      (lib.optional cfg.black pkgs.black)
      ++ (lib.optional cfg.stylua pkgs.stylua)
      ++ (lib.optional cfg.nixfmt pkgs.typstyle);

    lz-n = [
      {
        name = "conform.nvim";
        keys = [
          {
            mode = "n";
            key = "<leader>o";
            action = lib.mkLuaInline /* lua */ ''
              function()
                require("conform").format()
              end
            '';
            desc = "Conform format";
          }
        ];
        after = lib.mkLuaInline /* lua */ ''
          function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()";
            require("conform").setup({
              formatters_by_ft = {${
                (
                  (lib.optional cfg.black "python = { \"black\" }")
                  ++ (lib.optional cfg.stylua "lua = { \"stylua\" }")
                  ++ (lib.optional cfg.nixfmt "nix = { \"nixfmt\" }")
                  ++ (lib.optional cfg.typstyle "typst = { \"typstyle\" }")
                )
                |> lib.join ","
              }},
              default_format_opts = {
                lsp_format = "fallback",
                async = true,
              },
            })
          end
        '';
      }
    ];
  };
}
