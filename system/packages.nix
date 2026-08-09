{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Commandline Utils
    bash
    curl
    fd
    file
    fish
    lsof
    nix-output-monitor
    nps
    ripgrep
    vim

    # Filesystem Utils
    android-file-transfer
    archivemount
    cifs-utils
    cryptsetup
    rar
    unzip
    zip

    # Gui
    ungoogled-chromium

    # Wine
    wineWow64Packages.waylandFull
    winetricks

    # Look and Feel
    papirus-icon-theme
    liberation_ttf
  ];
}
