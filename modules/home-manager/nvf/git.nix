{ config, lib, ... }:
let
  cfg = config.custom.nvf;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.git = {
      git-conflict = {
        enable = true;
      };
      gitsigns = {
        enable = true;
        mappings = {
          nextHunk = "]g";
          previousHunk = "[g";
          blameLine = "<leader>gb";
          diffProject = "<leader>gD";
          diffThis = "<leader>gd";
          resetBuffer = "<leader>gR";
          resetHunk = "<leader>gr";
          stageBuffer = "<leader>gS";
          stageHunk = "<leader>gs";
          undoStageHunk = "<leader>gu";
          toggleDeleted = null;
        };
      };
      neogit = {
        enable = true;
        mappings = {
          commit = "<leader>gc";
          open = "<leader>gg";
          pull = "<leader>gp";
          push = "<leader>gP";
        };
        setupOpts = {
          integrations = {
            telescope = true;
            diffview = true;
          };
        };
      };
    };
  };
}
