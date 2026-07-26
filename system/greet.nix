{ pkgs, ... }: {
  # services.greetd.enable = true;
  # programs.regreet = {
  #   enable = true;
  #   theme = {
  #     package = pkgs.materia-theme;
  #     name = "Materia";
  #   };
  #   iconTheme = {
  #     package = pkgs.papirus-icon-theme;
  #     name = "Papirus";
  #   };
  # };
  services.getty.autologinUser = "jroid";
}
