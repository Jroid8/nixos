{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Commandline Utils
    age
    brightnessctl
    curl
    fastfetch
    fd
    file
    lm_sensors
    lsof
    neovim
    nix-output-monitor
    nix-tree
    pv
    ripgrep
    screen
    trash-cli
    inputs.agenix.packages.x86_64-linux.default

    # Filesystem Utils
    _7zz
    android-file-transfer
    archivemount
    cifs-utils
    cryptsetup
    rar
    squashfsTools
    squashfuse
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
