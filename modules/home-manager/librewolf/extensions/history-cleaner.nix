{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.custom.librewolf;
in
{
  config = lib.mkIf cfg.enable {
    programs.librewolf.profiles.default.extensions = {
      packages = with pkgs.nur.repos.rycee.firefox-addons; [
        history-cleaner
      ];
      settings."{a138007c-5ff6-4d10-83d9-0afaf0efbe5e}".settings = {
        behaviour = "days";
        days = 3;
        deleteMode = "startup";
      };
    };
  };
}
