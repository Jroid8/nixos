{ pkgs, ... }: {
  imports = [
    ./autocmds.nix
    ./autocomplete.nix
    ./rainbowcol.nix
    ./extra_lua.nix
    ./formatting.nix
    ./git.nix
    ./keymaps.nix
    ./languages.nix
    ./lsp.nix
    ./options.nix
    ./plugins.nix
    ./telescope.nix
    ./treesitter.nix
  ];
  programs.nvf = {
    enable = true;
    settings.vim = {
      vimAlias = false;
      viAlias = false;
      vendoredKeymaps.enable = true;
      extraPackages = [
        pkgs.fzf
        pkgs.ripgrep
      ];
      filetype = {
        extension = {
          ASM = "nasm";
          LIB = "nasm";
        };
      };
      ui.borders = {
        enable = true;
        globalStyle = "single";
      };
    };
  };
}
