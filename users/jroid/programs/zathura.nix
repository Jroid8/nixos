{ pkgs, ... }: {
  programs.zathura.enable = true;
  xdg.mimeApps.defaultApplicationPackages = with pkgs; [ zathura ];
}
