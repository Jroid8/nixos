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
      packages = [
        pkgs.nur.repos.rycee.firefox-addons.ublock-origin
      ];
      settings."uBlock0@raymondhill.net".settings = {
        advancedUserEnabled = true;
        selectedFilterLists = [
          "IRN-0"
          "easylist"
          "easyprivacy"
          "fanboy-cookiemonster"
          "fanboy-social"
          "ublock-annoyances"
          "ublock-badware"
          "ublock-cookies-easylist"
          "ublock-filters"
          "ublock-privacy"
          "ublock-quick-fixes"
          "ublock-unbreak"
          "urlhaus-1"
        ];
      };
    };
  };
}
