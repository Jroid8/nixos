{
  pkgs,
  lib,
  config,
  ...
}:
{
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
    enableManpages = true;
    defaultEditor = true;
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
  home.sessionVariables.EDITOR = lib.getExe config.programs.nvf.finalPackage;
}
