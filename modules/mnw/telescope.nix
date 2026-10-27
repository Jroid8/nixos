{ lib, pkgs, ... }: {
  plugins.opt = with pkgs.vimPlugins; [ telescope-nvim ];
  lz-n = [
    {
      name = "telescope.nvim";
      cmd = "Telescope";
      after = lib.mkLuaInline /* lua */ ''
        function()
          require("telescope").setup()
        end
      '';
      keys = [
        {
          key = "<A-f>";
          action = lib.mkLuaInline /* lua */ ''
            function()
              require("telescope.builtin").find_files()
            end
          '';
          mode = [ "n" ];
        }
        {
          key = "<leader>fg";
          action = lib.mkLuaInline /* lua */ ''
            function()
              require("telescope.builtin").live_grep()
            end
          '';
          mode = [ "n" ];
        }
      ];
    }
  ];
}
