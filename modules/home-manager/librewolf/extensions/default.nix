{ pkgs, ... }: {
  imports = [
    ./history-cleaner.nix
    ./tridactyl.nix
    ./ublockorigin.nix
  ];

  programs.librewolf.profiles.default = {
    settings = {
      "extensions.autoDisableScopes" = 0;
    };
    extensions = {
      force = true;
      packages = with pkgs.nur.repos.rycee.firefox-addons; [
        cookie-editor
        darkreader
        decentraleyes
        libredirect
      ];
    };
  };
}
