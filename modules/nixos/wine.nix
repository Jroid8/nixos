{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    custom.wine = {
      enable = lib.mkEnableOption "customized wine";
    };
  };
  config = lib.mkIf config.custom.wine.enable {
    nixpkgs.overlays = [
      (_: super: {
        wine = super.wineWow64Packages.waylandFull;
      })
    ];
    environment.systemPackages = with pkgs; [
      wine
      winetricks
    ];
  };
}
