{ pkgs, config, ... }:
{
  imports = [
    ./aboutconfig.nix
    ./extensions.nix
    ./search-engines.nix
  ];

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
  web-browser = config.programs.librewolf.finalPackage;
}
