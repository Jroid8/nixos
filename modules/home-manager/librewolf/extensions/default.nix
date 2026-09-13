{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.librewolf;
in
{
  config = lib.mkIf cfg.enable {
    programs.librewolf.profiles.default = {
      settings = {
        "extensions.autoDisableScopes" = 0;
      };
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          cookie-editor
          darkreader
          decentraleyes
          libredirect
        ];
      };
    };
  };
}
