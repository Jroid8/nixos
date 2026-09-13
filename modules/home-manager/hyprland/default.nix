{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.hyprland;
  cmdOption = lib.types.submodule {
    options = {
      command = lib.mkOption {
        type = lib.types.nonEmptyStr;
      };
      isShell = lib.mkOption {
        type = lib.types.boolByOr;
        default = false;
      };
    };
  };
in
{
  options = {
    custom.hyprland = {
      enable = lib.mkEnableOption "customized hyprland";
      aquamarine-drm-devices = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      rofi = lib.mkPackageOption pkgs "custom rofi" {
        default = [ "rofi" ];
      };
      gamelauncher = lib.mkPackageOption pkgs "game launcher" { };
      mps = lib.mkPackageOption pkgs "mps" { };
      terminalEmulator = lib.mkPackageOption pkgs "terminal emulator" {
        default = [ "kitty" ];
      };
      wallpaperSwitch = lib.mkOption {
        type = cmdOption;
      };
      textEditor = lib.mkOption {
        type = cmdOption;
      };
      openNotes = lib.mkOption {
        type = cmdOption;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      settings = {
        config = {
          input = {
            kb_layout = "us,ir";
            kb_options = "grp:alts_toggle";
            numlock_by_default = true;
            follow_mouse = 1;
            sensitivity = -0.2;
            touchpad = {
              natural_scroll = false;
            };
          };
          general =
            let
              gap = 7;
            in
            {
              gaps_in = gap;
              gaps_out = {
                top = 0;
                left = gap;
                right = gap;
                bottom = gap;
              };
              border_size = 2;

              allow_tearing = false;
              layout = "scrolling";
            };
          decoration = {
            rounding = 7;
            rounding_power = 2;
            shadow = {
              enabled = false;
            };
            blur = {
              enabled = false;
            };
          };
          animations = {
            enabled = true;
          };
          dwindle = {
            preserve_split = true;
          };
          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
          };
          ecosystem = {
            no_update_news = true;
          };
        };
        monitor = [
          {
            output = "eDP-1";
            mode = "preferred";
            position = "auto";
            scale = "auto";
          }
          # Mirror other displays to main
          {
            output = "";
            mode = "preferred";
            position = "auto";
            scale = "auto";
            mirror = "eDP-1";
          }
        ];
      };
      extraConfig = /* lua */ ''
        local ok, mod = pcall(require, "noctalia")
        if ok then
          mod.apply_theme()
        end
      '';
    };
    home.sessionVariables.AQ_DRM_DEVICES = cfg.aquamarine-drm-devices;
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };
  };
}
