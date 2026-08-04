{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bash
    cifs-utils
    cryptsetup
    curl
    fd
    file
    fish
    gcc
    lsof
    nix-output-monitor
    ripgrep
    ungoogled-chromium
    vim

    wineWow64Packages.waylandFull
    winetricks

    papirus-icon-theme
    liberation_ttf
  ];
}
