{ pkgs, ... }: {
  custom-pkgs.rofi = pkgs.rofi.override (old: {
    plugins = [ pkgs.rofi-calc ];
    theme = ./mytheme.rasi;
  });
  home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
}
