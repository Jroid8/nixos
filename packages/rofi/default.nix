{ pkgs, config, ... }: {
  custom-pkgs.rofi = pkgs.rofi.override (_: {
    plugins = [ pkgs.rofi-calc ];
    theme = ./mytheme.rasi;
  });
  home.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    config.custom-pkgs.rofi
  ];
}
