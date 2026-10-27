inputs:
let
  lib = inputs.nixpkgs.lib;
  supportedSystems = [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
  ];
in
lib.genAttrs supportedSystems (
  system:
  import ./my-packages.nix {
    inherit inputs system;
  }
)
