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
    git = {
      enable = true;
      config.safe.directory = "/etc/nixos";
    };
    hyprland.enable = true;
  };
}
