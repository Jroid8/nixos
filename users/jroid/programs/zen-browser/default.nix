{ config, inputs, ... }: {
  web-browser = config.programs.zen-browser.finalPackage;
  imports = [
    inputs.zen-browser.homeModules.twilight
    ./aboutconfig.nix
    ./containers.nix
    ./extensions.nix
    ./keyboard-shortcuts.nix
    ./mods.nix
    ./permissions.nix
    ./search-engines.nix
  ];
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    profiles.default.presets.betterfox.enable = true;
    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      InstallAddonsPermission.Default = false;
      NetworkPrediction = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      GenerativeAI = {
        Enabled = false;
        Locked = true;
      };
    };
  };
}
