{
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operator"
    ];
  };
  nixpkgs.config.allowUnfree = true;
}
