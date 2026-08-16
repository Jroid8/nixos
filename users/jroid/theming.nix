{ pkgs, ... }: {
  home.pointerCursor = {
    enable = true;
    name = "phinger-cursors-dark";
    size = 24;
    package = pkgs.phinger-cursors;
    hyprcursor.enable = true;
  };
  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };
  qt.platformTheme = "qtct";
}
