{ pkgs, ... }: {
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
      {
        name = "telescope-ui-select-nvim";
        packages = [ pkgs.vimPlugins.telescope-ui-select-nvim ];
      }
    ];
  };
}
