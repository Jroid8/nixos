{ pkgs, lib, config, ... }: {
  imports = [
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./theming.nix
  ];

  age.secretsDir = "/run/user/${builtins.toString config.home.uid}/agenix";

  xdg = {
    enable = true;
    mimeApps.enable = true;
  };

  custom = {
    global-fonts.enable = true;
  };

  home = {
    username = "jroid";
    uid = 1000;
    homeDirectory = "/home/jroid";
    stateVersion = "26.05";

    sessionVariables = {
      BROWSER = lib.getExe pkgs.librewolf;
      QT_QPA_PLATFORM = "wayland";
    };
  };
}
