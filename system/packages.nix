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
    nix-tree
    nps
    ripgrep
    vim

    # Filesystem Utils
    _7zz
    android-file-transfer
    archivemount
    cifs-utils
    cryptsetup
    rar
    unzip
    zip

    # Gui
    nix-visualize
    ungoogled-chromium

    # Wine
    wine
    winetricks

    # Look and Feel
    papirus-icon-theme
    liberation_ttf
  ];
}
