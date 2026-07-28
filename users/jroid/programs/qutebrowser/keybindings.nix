{ lib, config, ... }:
let
  qutebw = "${config.custom-pkgs.qute-bitwarden}/bin/qute-bitwarden";
in
{
  programs.qutebrowser.keyBindings = {
    normal = {
      ";v" = "hint links spawn --detach mpv {hint-url}";
      "gz" = lib.mkMerge [
        "config-cycle tabs.show never always"
        "config-cycle statusbar.show in-mode always"
        "config-cycle scrolling.bar never always"
      ];

      # Autofill
      "Ab" = "spawn --userscript ${qutebw}";
      "Ap" = "spawn --userscript ${qutebw} -w";
      "Au" = "spawn --userscript ${qutebw} -e";

      # Proxies
      "Vv" = "set content.proxy socks5://localhost:10808/";
      "Vt" = "set content.proxy socks5://localhost:9050/";
      "Vn" = "set content.proxy none";
    };
  };
}
