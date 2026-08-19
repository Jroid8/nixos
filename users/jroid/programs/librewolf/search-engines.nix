{ pkgs, ... }: {
  programs.librewolf.profiles.default.search = {
    force = true;
    engines = {
      nix-packages = {
        name = "Nix Packages";
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "np" ];
        urls = [
          {
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
      };
      wikipedia.definedAliases = [ "wi" ];

      bing.metaData.hidden = true;
      mojeek.metaData.hidden = true;
    };
  };
}
