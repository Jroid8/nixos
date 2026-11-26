{
  pkgs,
  dag,
  ...
}:
let
  nvim-treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (
    grammars: with grammars; [
      bash
      c
      css
      fish
      html
      javascript
      lua
      markdown
      nix
      python
      rust
      typescript
      typst
      tree-sitter-norg
      tree-sitter-norg-meta
    ]
  );
in
{
  extraBinPath = with pkgs; [ tree-sitter ];
  plugins.start = [ nvim-treesitter ];
  initLuaDag.treesitter-autocmd = dag.entryAnywhere /* lua */ ''
    local ts_augroup = vim.api.nvim_create_augroup("treesitter", {})
    local ts_activation_fn = 
    vim.api.nvim_create_autocmd("FileType", {
      group = treesitter_augroup,
      pattern = { 
        "bash",
        "c",
        "css",
        "fish",
        "html",
        "javascript", "javascriptreact",
        "lua",
        "markdown",
        "nix",
        "python",
        "rust",
        "typescript", "typescriptreact",
        "typst",
      },
      callback = function()
        vim.treesitter.start()
        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end,
    })
  '';
}
