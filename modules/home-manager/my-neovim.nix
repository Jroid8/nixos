{
  config,
  lib,
  mypkgs,
  ...
}:
let
  cfg = config.programs.my-neovim;
in
{
  options = {
    programs.my-neovim = {
      enable = lib.mkEnableOption "customized neovim";
      finalPackage = lib.mkOption {
        type = lib.types.package;
        readOnly = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.my-neovim.finalPackage = mypkgs.my-neovim;
    home = {
      packages = [ cfg.finalPackage ];
      shellAliases.v = "nvim";
    };
  };
}
