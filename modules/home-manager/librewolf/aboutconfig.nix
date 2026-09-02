{ config, lib, ... }:
let
  cfg = config.custom.librewolf;
in
{
  config = lib.mkIf cfg.enable {
    programs.librewolf.profiles.default.settings = {
      "browser.translations.neverTranslateLanguages" = "fa";
      "browser.urlbar.suggest.engines" = false;
      "browser.urlbar.suggest.openpage" = false;
    };
  };
}
