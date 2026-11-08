{
  pkgs,
  pkgs-cuda,
  inputs,
  ...
}:
{
  home.packages =
    (with pkgs; [
      # GUI
      localsend
      qbittorrent
      satty

      # CLI
      ddgr
      dragon-drop
      fastfetch
      grim
      jq
      kiwix-tools
      lm_sensors
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
      inputs.agenix.packages.x86_64-linux.default
      (pkgs-cuda.ffmpeg-full.override {
        withNvcodec = true;
      })
    ];
}
