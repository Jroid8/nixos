{ pkgs, ... }: {
  programs.nvf.settings.vim.treesitter = {
    enable = true;
    fold = true;
    autotagHtml = true;
    textobjects.enable = true;
    filetypeMappings = { };
    indent.excludes = [ ];
    grammars = with pkgs.vimPlugins.nvim-treesitter.grammarPlugins; [
      rust
      lua
      javascript
      typescript
      python
      html
      css
      markdown
      typst
      fish
    ];
  };
}
