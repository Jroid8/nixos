{ inputs, ... }: {
  nixpkgs.overlays = [
    (_: super: {
      wine = super.wineWow64Packages.waylandFull;
    })
    inputs.grim-hyprland.overlays.default
  ];
}
