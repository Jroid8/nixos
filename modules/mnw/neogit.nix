{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.neogit;
in
{
  options = {
    custom.neogit = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.opt = with pkgs.vimPlugins; [
      neogit
      diffview-nvim
    ];
    lz-n = [
      {
        name = "diffview.nvim";
        cmd = [
          "DiffviewOpen"
          "DiffviewFileHistory"
        ];
      }
      {
        name = "neogit";
        keys = [
          {
            mode = "n";
            key = "<leader>gg";
            action = "<Cmd>Neogit<CR>";
            desc = "open neogit";
          }
        ];
        cmd = "Neogit";
      }
    ];
  };
}
