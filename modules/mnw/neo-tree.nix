{
  config,
  pkgs,
  lib,
  dag,
  ...
}:
let
  cfg = config.custom.neo-tree;
in
{

  options = {
    custom.neo-tree = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.start = with pkgs.vimPlugins; [
      plenary-nvim
      nui-nvim
      nvim-web-devicons
      neo-tree-nvim
    ];

    initLuaDag.neo-tree-setup = dag.entryAfter [ "leader-key-assign" ] /* lua */ ''
      vim.keymap.set("n", "<leader>e",
        function()
          local reveal_file = vim.fn.expand('%:p')
          if reveal_file == "" then
            reveal_file = vim.fn.getcwd()
          else
            local f = io.open(reveal_file, "r")
            if f then
              f.close(f)
            else
              reveal_file = vim.fn.getcwd()
            end
          end
          require('neo-tree.command').execute({
            reveal_file = reveal_file,
            reveal_force_cwd = true,
            toggle = true,
          })
        end,
        { desc = "toggle neo-tree"}
      )
      require("neo-tree").setup({
        log_level = vim.log.levels.WARN,
        open_files_do_not_replace_types = { "terminal", "qf", "toggleterm" },
        filesystem = {
          hijack_netrw_behavior = "disabled",
          use_libuv_file_watcher = false,
          filtered_items = {
            always_show = {
              "index.norg"
            },
          },
        },
      })
    '';
  };
}
