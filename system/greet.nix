{ pkgs, ... }: {
  programs.regreet = {
    enable = true;
    cursorTheme = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
    };
    font = {
      name = "Ubuntu Sans";
      package = pkgs.ubuntu-sans;
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    settings = {
      GTK.application_prefer_dark_theme = true;
      background.path = builtins.toString pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src;
    };
    extraCss = /* css */ ''
      picture {
      	background-color: #222;
      }
    '';
  };
}
