{
  pkgs,
  config,
  lib,
  dag,
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

  config = lib.mkIf cfg.enable {
    plugins.start = [ pkgs.vimPlugins.rustaceanvim ];
    initLuaDag.rustaceanvim-config-assign = dag.entryAnywhere /* lua */ ''
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
