{ pkgs, ... }: {
  programs.librewolf.profiles.default.extensions = {
    packages = with pkgs.nur.repos.rycee.firefox-addons; [
      tridactyl
    ];
    settings."tridactyl.vim@cmcaine.co.uk".settings = {
      userconfig = {
        proxies = {
          v2ray = "socks5://localhost:10808";
          tor = "socks5://localhost:9050";
        };
      };
    };
  };
}
