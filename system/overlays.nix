{ inputs, ... }: {
  nixpkgs.overlays = [
    inputs.grim-hyprland.overlays.default
  ];
}
