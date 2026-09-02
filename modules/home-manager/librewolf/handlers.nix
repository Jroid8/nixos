{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.custom.librewolf;
in
{
  config = lib.mkIf cfg.enable {
    programs.librewolf.profiles.default.handlers = {
      mimeTypes = {
        "application/pdf" = {
          action = 2;
          ask = false;
          handlers = [
            {
              name = "Zathura";
              path = lib.getExe pkgs.zathura;
            }
          ];
          extensions = [ "pdf" ];
        };
      };
      schemes = {
        magnet = {
          action = 2;
          ask = false;
          handlers = [
            {
              name = "qbittorrent";
              path = lib.getExe pkgs.qbittorrent;
            }
          ];
        };
      };
    };
  };
}
