{ pkgs, ... }: {
  home.packages = with pkgs; [
    # GUI
    v2rayn
    satty
    localsend

    # CLI
    dragon-drop
    fastfetch
    grim
    jq
    lm_sensors
    mpc
    nixfmt
    python3
    wl-clipboard

    # Libreoffice
    libreoffice-qt
    hunspell
    hunspellDicts.en-us
    hunspellDicts.fa-ir

    # Art
    blender
    krita
    krita-plugin-gmic
    inkscape
  ];
}
