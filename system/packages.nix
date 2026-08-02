{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    file
    ungoogled-chromium
    bash
    cifs-utils
    cryptsetup
    curl
    fd
    fish
    gcc
    ripgrep
    vim

    wineWow64Packages.waylandFull
    winetricks

    liberation_ttf
  ];
}
