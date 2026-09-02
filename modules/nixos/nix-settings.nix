{ lib, config, ... }: {
  options = {
    custom.nix-settings = {
      enable = lib.mkEnableOption "customized nix settings";
    };
  };
  config = lib.mkIf config.custom.nix-settings.enable {
    nix.settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operator"
      ];
    };
    nixpkgs.config.allowUnfree = true;
  };
}
