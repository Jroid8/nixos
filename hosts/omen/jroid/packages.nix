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
      dust
      grim
      jq
      kiwix-tools
      mupdf
      python3
      squashfsTools
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
