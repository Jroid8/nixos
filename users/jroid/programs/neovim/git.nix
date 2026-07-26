{
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
        stageBuffer = "<leader>gs";
        stageHunk = "<leader>gS";
        undoStageHunk = "<leader>gu";
        toggleDeleted = null;
      };
    };
    neogit = {
      enable = true;
      mappings = {
        commit = null;
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
}
