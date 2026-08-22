{ pkgs, lib, ... }: {
  programs.librewolf.profiles.default.search = {
    force = true;
    default = "policy-DuckDuckGo Lite";
    privateDefault = "policy-DuckDuckGo Lite";
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
    }
    // (lib.attrsets.genAttrs' [ "policy-MetaGer" "policy-Mojeek" ] (id: {
      name = id;
      value = {
        metaData.hidden = true;
      };
    }));
  };
}
