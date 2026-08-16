{ pkgs, lib, ... }: {
  programs.nvf.settings.vim = {
    hideSearchHighlight = true;
    searchCase = "smart";
    syntaxHighlighting = true;
    undoFile.enable = true;
    clipboard = {
      enable = true;
      providers.wl-copy.enable = true;
      registers = "unnamedplus";
    };
    globals = {
      mapleader = " ";
    };
    options = {
      expandtab = false;
      tabstop = 2;
      shiftwidth = 2;
      mouse = "a";
      incsearch = true;
      termguicolors = true;
      smartindent = true;
      conceallevel = 2;
      concealcursor = "n";
      linebreak = true;
      number = true;
      relativenumber = true;
      splitright = true;
      exrc = true;
      foldlevelstart = 99;
      shell = lib.getExe pkgs.fish;
      indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()";
      foldmethod = "expr";
      foldexpr = "v:lua.vim.treesitter.foldexpr()";
    };
    # spellcheck = {
    #   programmingWordlist.enable = true;
    # };
  };
}
