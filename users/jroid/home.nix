{
  config,
  lib,
  inputs,
  pkgs,
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
      AQ_DRM_DEVICES = "/dev/dri/intel-igpu";
      GRIM_DEFAULT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
      QT_QPA_PLATFORM = "wayland";
    };

    home.shellAliases = (import ../../system/aliases.nix) // {
      yt720 = "yt-dlp -f 'bv[height<=720][fps<=?30]+ba[abr<=?95][language*=?en]/bv[height<=720]+ba[language*=?en]'";
      rfb = "rofi -show filebrowser -config filebrowser -filebrowser-directory";
      tree = "eza --tree";
    };
    home.shell.enableBashIntegration = true;

    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-hyprland
        ];
      };
      mimeApps.enable = true;
    };
  };
}
