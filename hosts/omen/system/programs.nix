{ inputs, ... }: {
  programs = {
    fish.enable = true;
    bash.enable = true;
    git.enable = true;
    hyprland.enable = true;
    nix-ld.enable = true;
    nix-index-database.comma.enable = true;
    nix-index.package = inputs.nix-index-database.packages."x86_64-linux".nix-index-with-db;
  };
  security.pam.services.hyprlock.enable = true;
  custom = {
    wine.enable = true;
  };
}
