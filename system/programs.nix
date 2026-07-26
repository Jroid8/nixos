{
  programs = {
    fish = {
      enable = true;
      shellAliases = import ./aliases.nix;
    };
    bash = {
      enable = true;
      shellAliases = import ./aliases.nix;
    };
    hyprland.enable = true;
  };
}
