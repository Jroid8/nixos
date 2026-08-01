{ pkgs, ... }: {
  home.packages = with pkgs; [
    # GUI
    v2rayn
    rofi
    satty
    localsend

    # CLI
    jq
    nixfmt
    python3
    wl-clipboard
    fastfetch
    grim
    lm_sensors
    mpc

    # Art
    blender
    krita
    krita-plugin-gmic
    inkscape
  ];
}
