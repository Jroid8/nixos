{ pkgs, ... }: {
  home.packages = with pkgs; [
    # GUI
    v2rayn
    rofi
    satty

    # CLI
    fastfetch
    mpc
    grim
    bitwarden-cli
    lm_sensors

    # Art
    blender
    krita
    krita-plugin-gmic
    inkscape
  ];
}
