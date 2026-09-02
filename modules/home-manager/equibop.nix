{ config, lib, ... }:
let
  cfg = config.custom.equibop;
in
{
  options = {
    custom.equibop.enable = lib.mkEnableOption "customized equibop";
  };
  config = lib.mkIf cfg.enable {
    programs.equibop = {
      enable = true;
      settings = {
        appBadge = false;
        arRPC = true;
        checkUpdates = false;
        customTitleBar = false;
        disableMinSize = true;
        minimizeToTray = false;
        hardwareAcceleration = true;
        discordBranch = "stable";
      };
      equicord.settings = {
        autoUpdate = false;
        autoUpdateNotification = false;
      };
    };
  };
}
