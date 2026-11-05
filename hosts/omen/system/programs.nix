{
  programs = {
    fish.enable = true;
    bash.enable = true;
    git.enable = true;
    hyprland.enable = true;
    nix-ld.enable = true;
  };
  security.pam.services.hyprlock.enable = true;
  custom = {
    wine.enable = true;
  };
}
