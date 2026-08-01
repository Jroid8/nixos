{ lib, config, ... }:
{
  programs.qutebrowser.keyBindings = {
    normal = {
      ";v" = "hint links spawn --detach mpv {hint-url}";
      "gz" = lib.mkMerge [
        "config-cycle tabs.show never always"
        "config-cycle statusbar.show in-mode always"
        "config-cycle scrolling.bar never always"
      ];

      # Proxies
      "gvv" = "set content.proxy socks5://localhost:10808/";
      "gvt" = "set content.proxy socks5://localhost:9050/";
      "gvn" = "set content.proxy none";
    };
  };
}
