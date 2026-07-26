{ pkgs, ... }:
let
  papirus-icons = "${pkgs.papirus-icon-theme}/usr/share/icons/Papirus-Dark/64x64/apps";
in
{
  programs.zen-browser.profiles.default.search = {
    force = true;
    default = "ddg";
    engines = {
      mynixos = {
        name = "My NixOS";
        urls = [
          {
            template = "https://mynixos.com/search?q={searchTerms}";
          }
        ];
        icon = "${papirus-icons}/nix-snowflake.svg";
        definedAliases = [ "nix" ];
      };
      github = {
        name = "GitHub Search";
        urls = [
          {
            template = "https://github.com/search?q={searchTerms}";
          }
        ];
        definedAliases = [ "gh" ];
        icon = "${papirus-icons}/github.svg";
      };
      google-images = {
        name = "Google Images";
        urls = [
          {
            template = "https://www.google.com/search?q={searchTerms}&udm=2";
          }
        ];
        definedAliases = "ggi";
        icon = "${papirus-icons}/google.svg";
      };
      youtube = {
        name = "YouTube";
        urls = [
          {
            template = "https://www.youtube.com/results?search_query={searchTerms}";
          }
        ];
        definedAliases = "yt";
        icon = "${papirus-icons}/youtube.svg";
      };

      bing.metaData.hidden = true;
      perplexity.metaData.hidden = true;
      google.metaData.alias = "gg";
      wikipedia.metaData.alias = "wi";
    };
  };
}
