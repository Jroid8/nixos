{
  config,
  pkgs,
  lib,
  ...
}:
let
  mkArgs = _args: { inherit _args; };
  inherit (lib.generators) mkLuaInline;
  catchAll = [
    "catchall"
    (mkLuaInline "hl.dsp.submap(\"reset\")")
  ];
  hl_dsp = func: cmd: mkLuaInline ''hl.dsp.${func}("${cmd}")'';
	/*nixfmt:disable*/
  directional_keys = [
		{ key = "H"; name = "left"; }
		{ key = "L"; name = "right"; }
		{ key = "K"; name = "up"; }
		{ key = "J"; name = "down"; }
  ];
	/*nixfmt:enable*/
  scsh_name_fmt = "$(date '+%Y-%m-%d_%H-%M-%S')";
  scsh_edsv = "${lib.getExe pkgs.satty} -f - -o ~/Pictures/Screenshots/${scsh_name_fmt}.png";

  browser = lib.getExe config.web-browser;
  rofi = lib.getExe config.custom-pkgs.rofi;
  gametime = "${config.custom-pkgs.gametime}/bin/gametime";
  boot-to-windows = "${config.custom-pkgs.boot-to-windows}/bin/boot-to-windows";
  mps = "${config.custom-pkgs.mps}/bin/mps";
  term = lib.getExe config.terminal-emulator;
  wpctl = "${pkgs.wireplumber.out}/bin/wpctl";
  brightnessctl = lib.getExe pkgs.brightnessctl;
  playerctl = lib.getExe pkgs.playerctl;
  noctalia = lib.getExe config.programs.noctalia.package;
  systemctl = "${pkgs.systemd.out}/bin/systemctl";
  grim = lib.getExe pkgs.grim;
  hyprctl = "${config.wayland.windowManager.hyprland.finalPackage}/bin/hyprctl";
  jq = lib.getExe pkgs.jq;
in
{
  wayland.windowManager.hyprland = {
    settings.bind =
      builtins.map mkArgs [
        # Submap Leaders
        [
          "SUPER + D"
          (hl_dsp "submap" "launch_app")
        ]
        [
          "SUPER + S"
          (hl_dsp "submap" "workspace_switch")
        ]
        [
          "SUPER + G"
          (hl_dsp "submap" "group_manage")
        ]

        # Quick Apps
        [
          "SUPER + Return"
          (hl_dsp "exec_raw" term)
        ]
        [
          "SUPER + Space"
          (hl_dsp "exec_raw" "${rofi} -show run -modes run,drun,calc -show-icons -disable-history -case-smart -terse -calc-command 'echo -n '{result}' | wl-copy' -reuse-result")
        ]

        # Quick Window Management
        [
          "SUPER + CTRL + C"
          (mkLuaInline "hl.dsp.window.close()")
        ]
        [
          "SUPER + CTRL + F"
          (mkLuaInline "hl.dsp.window.float({ action = \"toggle\" })")
        ]
        [
          "SUPER + Bracketleft"
          (hl_dsp "layout" "colresize -0.0625")
        ]
        [
          "SUPER + Bracketright"
          (hl_dsp "layout" "colresize +0.0625")
        ]

        # Quick Group Member Switching
        [
          "SUPER + ALT + Period"
          (mkLuaInline "hl.dsp.group.next()")
        ]
        [
          "SUPER + ALT + Comma"
          (mkLuaInline "hl.dsp.group.prev()")
        ]

        # F1-12 Keys
        [
          "SUPER + ALT + F12"
          (hl_dsp "exec_raw" boot-to-windows)
        ]
        [
          "SUPER + CTRL + F12"
          (hl_dsp "exec_raw" "${systemctl} reboot")
        ]
        [
          "SUPER + SHIFT + F12"
          (hl_dsp "exec_raw" "${systemctl} suspend")
        ]
        [
          "SUPER + F11"
          (hl_dsp "exec_raw" "${noctalia} msg wallpaper-next")
        ]

        # Keyboard Special Keys
        [
          "Print"
          (hl_dsp "exec_cmd" "${grim} ~/Pictures/Screenshots/${scsh_name_fmt}.png")
        ]
        [
          "SUPER + Print"
          (hl_dsp "exec_cmd" ''${grim} -w \"$(${hyprctl} activewindow -j | ${jq} -r '.address')\" ~/Pictures/Screenshots/${scsh_name_fmt}.png'')
        ]
        [
          "ALT + Print"
          (hl_dsp "exec_cmd" "${grim} -t ppm - | ${scsh_edsv}")
        ]
        [
          "SUPER + ALT + Print"
          (hl_dsp "exec_cmd" ''${grim} -w \"$(${hyprctl} activewindow -j | ${jq} -r '.address')\" -t ppm - | ${scsh_edsv}'')
        ]
        [
          "XF86AudioRaiseVolume"
          (hl_dsp "exec_raw" "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+")
          {
            locked = true;
            repeating = true;
          }
        ]
        [
          "XF86AudioLowerVolume"
          (hl_dsp "exec_raw" "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-")
          {
            locked = true;
            repeating = true;
          }
        ]
        [
          "XF86AudioMute"
          (hl_dsp "exec_raw" "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle")
          { locked = true; }
        ]
        [
          "XF86MonBrightnessUp"
          (hl_dsp "exec_raw" "${brightnessctl} -e4 set 5%+")
          {
            locked = true;
            repeating = true;
          }
        ]
        [
          "XF86MonBrightnessDown"
          (hl_dsp "exec_raw" "${brightnessctl} -e4 set 5%-")
          {
            locked = true;
            repeating = true;
          }
        ]
        [
          "XF86AudioNext"
          (hl_dsp "exec_raw" "${playerctl} next")
        ]
        [
          "XF86AudioPrev"
          (hl_dsp "exec_raw" "${playerctl} previous")
        ]
        [
          "XF86AudioPause"
          (hl_dsp "exec_raw" "${playerctl} play-pause")
        ]
        [
          "XF86AudioPlay"
          (hl_dsp "exec_raw" "${playerctl} play-pause")
        ]

        # Mouse
        [
          "SUPER + mouse:272"
          (mkLuaInline "hl.dsp.window.drag()")
          { mouse = true; }
        ]
        [
          "SUPER + mouse:273"
          (mkLuaInline "hl.dsp.window.resize()")
          { mouse = true; }
        ]
      ]
      ++ (lib.attrsets.mapCartesianProduct
        (
          { direction, action }:
          mkArgs [
            "SUPER ${action.mod}+ ${direction.key}"
            (mkLuaInline ''hl.dsp.${action.function}({ direction = "${direction.name}" })'')
          ]
        )
        {
          direction = directional_keys;
          action = [
						/*nixfmt:disable*/
            { mod = ""; function = "focus"; }
            { mod = "+ SHIFT "; function = "window.swap"; }
            { mod = "+ CTRL "; function = "window.move"; }
						/*nixfmt:enable*/
          ];
        }
      );
    submaps = {
      launch_app = {
        onDispatch = "reset";
        settings = {
          bind = builtins.map mkArgs [
            [
              "G"
              (hl_dsp "exec_raw" gametime)
            ]
            [
              "P"
              (hl_dsp "exec_raw" "${mps} plsel")
            ]
            [
              "ALT + P"
              (hl_dsp "exec_raw" "${mps} msel")
            ]
            [
              "D"
              (hl_dsp "exec_raw" (lib.getExe pkgs.equibop))
            ]
            [
              "E"
              (hl_dsp "exec_raw" browser)
            ]
            # [
            #   "ALT + E"
            #   (hl_dsp "exec_raw" (lib.getExe pkgs.ungoogled-chromium))
            # ]
            # [
            #   "M"
            #   (hl_dsp "exec_raw" (lib.getExe pkgs.prismlauncher))
            # ]
            [
              "N"
              (hl_dsp "exec_raw" "${term} ${config.programs.nvf.finalPackage} +:SelectProject")
            ]
            [
              "T"
              (hl_dsp "exec_raw" "${term} -d Notes ${config.programs.nvf.finalPackage} index.norg")
            ]
            [
              "F"
              (hl_dsp "exec_raw" "${term} ${lib.getExe pkgs.yazi}")
            ]
            catchAll
          ];
        };
      };
      group_manage = {
        onDispatch = "reset";
        settings = {
          bind =
            builtins.map mkArgs [
              [
                "Space"
                (mkLuaInline "hl.dsp.group.toggle()")
              ]
              catchAll
            ]
            ++ (builtins.map (
              { key, name }:
              mkArgs [
                key
                (mkLuaInline "hl.dsp.window.move({into_or_create_group = \"${name}\"})")
              ]
            ) directional_keys);
        };
      };
    };
    extraConfig = /* lua */ ''
      hl.define_submap("workspace_switch", "reset", function ()
      	for cc = string.byte('A'), string.byte('Z') do
      		local ch = string.char(cc)
      		hl.bind(ch, hl.dsp.focus({ workspace = "name:" .. ch }))
      		hl.bind("SHIFT + " .. ch, hl.dsp.window.move({ workspace = ch, follow = false }))
      		hl.bind("SHIFT + ALT + " .. ch, hl.dsp.window.move({ workspace = ch, follow = true }))
      	end
      	hl.bind("catchall", hl.dsp.submap("reset"))
      end)
    '';
  };
}
