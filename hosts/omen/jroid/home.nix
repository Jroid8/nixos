{ pkgs, lib, ... }: {
  imports = [
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./theming.nix
  ];

  xdg = {
    mimeApps.enable = true;
  };

  custom = {
    global-fonts.enable = true;
  };

  home = {
    username = "jroid";
    homeDirectory = "/home/jroid";
    stateVersion = "26.05";

    sessionVariables = {
      BROWSER = lib.getExe pkgs.librewolf;
      QT_QPA_PLATFORM = "wayland";
    };
  };
}
