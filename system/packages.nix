{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bash
    cifs-utils
    cryptsetup
    curl
    fd
    fish
    gcc
    git
    ripgrep
    vim

    wineWow64Packages.waylandFull
    winetricks

    liberation_ttf
  ];
}
