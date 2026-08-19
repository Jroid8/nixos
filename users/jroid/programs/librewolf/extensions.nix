{ pkgs, ... }: {
  programs.librewolf = {
    profiles.default = {
      settings = {
        "extensions.autoDisableScopes" = 0;
      };
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          cookie-editor
          darkreader
          decentraleyes
          history-cleaner
          libredirect
          tridactyl
          ublock-origin
        ];
        settings = {
          "uBlock0@raymondhill.net".settings = {
            advancedUserEnabled = true;
            selectedFilterLists = [
              "IRN-0"
              "easylist"
              "easyprivacy"
              "fanboy-cookiemonster"
              "fanboy-social"
              "ublock-annoyances"
              "ublock-badware"
              "ublock-cookies-easylist"
              "ublock-filters"
              "ublock-privacy"
              "ublock-quick-fixes"
              "ublock-unbreak"
              "urlhaus-1"
            ];
          };
          "{a138007c-5ff6-4d10-83d9-0afaf0efbe5e}".settings = {
            behaviour = "days";
            days = 3;
            deleteMode = "startup";
          };
        };
      };
    };
  };
}
