{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Commandline Utils
    curl
    fd
    file
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

    # Look and Feel
    papirus-icon-theme
    liberation_ttf
  ];
}
