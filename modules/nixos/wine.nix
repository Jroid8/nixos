{ pkgs, ... }: {
  nixpkgs.overlays = [
    (_: super: {
      wine = super.wineWow64Packages.waylandFull;
    })
  ];
  environment.systemPackages = with pkgs; [
    wine
    winetricks
  ];
}
