{ pkgs, config, lib, ... }:
let
  cfg = config.custom.librewolf;
in
{
  options = {
    custom.librewolf = {
      enable = lib.mkEnableOption "customized librewolf";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
      nativeMessagingHosts = [
        pkgs.tridactyl-native
      ];
      policies = {
        DisableSetDesktopBackground = true;
        DisableFeedbackCommands = true;
      };
      profiles.default = {
        containersForce = true;
        containers = {
          personal = {
            color = "blue";
            icon = "fingerprint";
            id = 1;
          };
          shopping = {
            color = "yellow";
            icon = "cart";
            id = 2;
          };
        };
      };
    };
  };
}
