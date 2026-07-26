{
  imports = [
    ./animation.nix
		./keybinds.nix
    ./services.nix
		./window-rules.nix
		./workspace-rules.nix
  ];

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
}
