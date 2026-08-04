{
  pkgs,
  inputs,
  pkgs-cuda,
  ...
}:
{
  home.packages =
    (with pkgs; [
      # GUI
      localsend
      satty

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
      krita
      krita-plugin-gmic
      inkscape
    ])
    ++ [
      pkgs-cuda.blender
      inputs.self.packages.ffmpeg-full
    ];
}
