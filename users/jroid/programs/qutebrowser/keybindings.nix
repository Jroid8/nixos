{ lib, ... }:
{
  programs.qutebrowser.keyBindings = {
    normal = {
      ";v" = "hint links spawn --detach mpv {hint-url}";
      "gz" = lib.mkMerge [
        "config-cycle -t tabs.show never always"
        "config-cycle -t statusbar.show in-mode always"
        "config-cycle -t scrolling.bar never always"
      ];

      # Proxies
      "gvv" = "set -t -p content.proxy socks5://localhost:10808/";
      "gvt" = "set -t -p content.proxy socks5://localhost:9050/";
      "gvn" = "set -t -p content.proxy none";
    };
  };
}
