{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.keepassxc;
in
{
  options = {
    custom.keepassxc = {
      enable = lib.mkEnableOption "customized keepassxc";
    };
  };
  config = lib.mkIf cfg.enable {
    services.ssh-agent.enable = true;
    programs.keepassxc = {
      enable = true;
      settings = {
        General = {
          ConfigVersion = 2;
          AutoGeneratePasswordForNewEntries = true;
          OpenPreviousDatabasesOnStartup = false;
        };
        GUI = {
          AdvancedSettings = true;
          ApplicationTheme = "dark";
          CompactMode = true;
          HidePasswords = true;

          MinimizeOnClose = true;
          MinimizeToTray = true;
          ShowTrayIcon = true;
          TrayIconAppearance = "monochrome-dark";
        };
        Browser = {
          Enabled = true;
        };
        SSHAgent = {
          Enabled = true;
        };
        Security = {
          Security_HideNotes = true;
          IconDownloadFallback = true;
        };
      };
    };
    programs.librewolf = lib.mkIf config.programs.librewolf.enable {
      nativeMessagingHosts = [
        pkgs.keepassxc
      ];
      profiles.default.extensions.packages = [
        pkgs.nur.repos.rycee.firefox-addons.keepassxc-browser
      ];
    };
  };
}
