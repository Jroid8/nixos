# programs.zen-browser.policies =
# let
#   mkExtensionSettings = builtins.mapAttrs (
#     _: pluginId: {
#       install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
#       installation_mode = "force_installed";
#     }
#   );
# in
# {
# ExtensionSettings = mkExtensionSettings {
# "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
# "CanvasBlocker@kkapsner.de" = "canvasblocker";
# "gdpr@cavi.au.dk" = "consent-o-matic";
# "{c3c10168-4186-445c-9c5b-63f12b8e2c87}" = "Cookie-Editor";
# "deArrow@ajay.app" = "dearrow";
# "jid1-BoFifL9Vbdl2zQ@jetpack" = "decentraleyes";
# "addon@fastforward.team" = "fastforwardteam";
# "foxyproxy@eric.h.jung" = "foxyproxy-standard";
# "{a138007c-5ff6-4d10-83d9-0afaf0efbe5e}" = "history-cleaner";
# "{cb31ec5d-c49a-4e5a-b240-16c767444f62}" = "indie-wiki-buddy";
# "7esoorv3@alefvanoon.anonaddy.me" = "libredirect";
# "{531906d3-e22f-4a6c-a102-8057b88a1a63}" = "single-file";
# "{74186d10-f6f2-4f73-b33a-83bb72e50654}" = "transparent-zen";
# "uBlock0@raymondhill.net" = "ublock-origin";
# "MinYT@example.org" = "youtube-suite-search-fixer";
#   };
# };
{ inputs, pkgs, ... }:
let
  firefox-addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.zen-browser = {
    profiles.default.extensions.packages = with firefox-addons; [
      canvasblocker
      consent-o-matic
      cookie-editor
      dearrow
      decentraleyes
      fastforwardteam
      foxyproxy-standard
      history-cleaner
      historyblock
      indie-wiki-buddy
      libredirect
      single-file
      transparent-zen
      ublock-origin
      youtube-suite-search-fixer
    ];
    policies."3rdparty" = {
      "uBlock0@raymondhill.net".adminSettings = {
				userSettings.advancedUserEnabled = true;
        selectedFilterLists = [
          "user-filters"
          "ublock-filters"
          "ublock-badware"
          "ublock-privacy"
          "ublock-quick-fixes"
          "ublock-unbreak"
          "easylist"
          "easyprivacy"
          "urlhaus-1"
          "plowe-0"
          "fanboy-cookiemonster"
          "ublock-cookies-easylist"
          "adguard-cookies"
          "ublock-cookies-adguard"
          "fanboy-social"
          "fanboy-ai-suggestions"
          "easylist-chat"
          "easylist-newsletters"
          "easylist-notifications"
          "easylist-annoyances"
          "ublock-annoyances"
          "IRN-0"
        ];
      };
    };
  };
}
