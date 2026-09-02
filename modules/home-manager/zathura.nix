{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.zathura;
in
{
  options = {
    custom.zathura.enable = lib.mkEnableOption "customized zathura";
  };
  config = lib.mkIf cfg.enable {
    programs.zathura.enable = true;
    xdg.mimeApps.defaultApplicationPackages = with pkgs; [ zathura ];
  };
}
