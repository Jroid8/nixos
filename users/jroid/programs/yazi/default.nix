{ pkgs, ... }: {
  imports = [ ./keymaps.nix ];

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    plugins = {
      inherit (pkgs.yaziPlugins) bookmarks mount;
    };
  };
}
