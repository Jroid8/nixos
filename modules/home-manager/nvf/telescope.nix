{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.nvf;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.telescope = {
      enable = true;
      extensions = [
        {
          name = "fzf";
          packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
          setup = {
            fzf = {
              fuzzy = true;
              override_generic_sorter = true;
              override_file_sorter = true;
              case_mode = "smart_case";
            };
          };
        }
      ];
    };
  };
}
