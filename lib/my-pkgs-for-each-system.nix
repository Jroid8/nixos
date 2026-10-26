nixpkgs:
nixpkgs.lib.genAttrs [ "aarch64-linux" "i686-linux" "x86_64-linux" ] (
  system: import ./my-packages.nix nixpkgs.legacyPackages.${system}
)
