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
      age
      ddgr
      dragon-drop
      brightnessctl
      dust
      fastfetch
      grim
      jq
      kiwix-tools
      lm_sensors
      mupdf
      python3
      squashfsTools
      trash-cli
      wl-clipboard
      yq

      # Libreoffice
      libreoffice-qt
      hunspell
      hunspellDicts.en-us
      hunspellDicts.fa-ir

      # Art
      krita
      krita-plugin-gmic
      inkscape

      man-pages-posix
    ])
    ++ [
      pkgs-cuda.blender
      inputs.agenix.packages.x86_64-linux.default
      (pkgs-cuda.ffmpeg-full.override {
        withNvcodec = true;
      })
    ];
}
