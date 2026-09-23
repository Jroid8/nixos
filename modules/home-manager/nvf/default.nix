{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.custom.nvf;
in
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];
  options = {
    custom.nvf = {
      enable = lib.mkEnableOption "customized nvf";
    };
  };
  config = lib.mkIf cfg.enable {
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
    home.shellAliases = {
      v = "nvim";
    };
  };
}
