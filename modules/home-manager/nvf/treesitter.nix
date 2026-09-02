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
    programs.nvf.settings.vim.treesitter = {
      enable = true;
      fold = true;
      autotagHtml = true;
      textobjects.enable = true;
      filetypeMappings = { };
      indent.enable = true;
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
  };
}
