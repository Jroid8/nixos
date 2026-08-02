{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
    inputs.nvf.homeManagerModules.default
    ./programs
    ./scripts
    ./services
    ./fonts.nix
    ./packages.nix
    ./theming.nix
  ];

  options = {
    terminal-emulator = lib.mkOption {
      type = lib.types.package;
    };
    web-browser = lib.mkOption {
      type = lib.types.package;
    };
    custom-pkgs = lib.mkOption {
      type = lib.types.submodule {
        options =
          lib.genAttrs'
            [
              "rofi"
              "mps"
              "gametime"
              "boot-to-windows"
              "yazi-select"
            ]
            (name: {
              inherit name;
              value = lib.mkOption {
                type = lib.types.package;
              };
            });
      };
    };
  };

  config = {
    # Home Manager
    home = {
      username = "jroid";
      homeDirectory = "/home/jroid";
      stateVersion = "26.05";
    };
    programs.home-manager.enable = true;

    home.sessionVariables = {
      GRIM_DEFAULT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
      QT_QPA_PLATFORM = "wayland";
    };
  };
}
