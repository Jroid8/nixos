{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.rustaceanvim;
in
{
  options = {
    custom.rustaceanvim = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.rustaceanvim {
    plugins.start = [ pkgs.vimPlugins.rustaceanvim ];
    initLua = /* lua */ ''
      vim.g.rustaceanvim = {
        tools = {
          enable_clippy = false,
          hover_actions = {
            replace_builtin_hover = false,
          },
        },
        server = {
          cmd = { "rust-analyzer" },
          default_settings = {
            ['rust-analyzer'] = {
              diagnostics = {
                disabled = { "inactive-code" },
              },
            },
          },
        },
      };
    '';
  };
}
