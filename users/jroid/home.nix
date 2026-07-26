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
        options = {
          rofi = lib.mkOption {
            type = lib.types.package;
          };
          mps = lib.mkOption {
            type = lib.types.package;
          };
          gametime = lib.mkOption {
            type = lib.types.package;
          };
          boot-to-windows = lib.mkOption {
            type = lib.types.package;
          };
        };
      };
    };
  };

  config = {
    # Home Manager
    home.username = "jroid";
    home.homeDirectory = "/home/jroid";
    home.stateVersion = "26.05";
    programs.home-manager.enable = true;

    home.sessionVariables = {
      XCURSOR_SIZE = 24;
      HYPRCURSOR_SIZE = 24;
      GRIM_DEFAULT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
      #	__EGL_VENDOR_LIBRARY_FILENAMES = "/nix/store/.../share/glvnd/egl_vendor.d/50_mesa.json";
      #	VK_DRIVER_FILES = "/nix/store/.../share/vulkan/icd.d/intel_icd.json";
      #	__GLX_VENDOR_LIBRARY_NAME = "mesa";
    };
  };
}
