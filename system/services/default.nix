{ lib, pkgs, ... }: {
  imports = [ ./nbfc.nix ];

  services = {
    tuned.enable = true;
    upower.enable = true;
    udisks2.enable = true;
    kanata = {
      enable = true;
      keyboards.default = {
        config = ''
          (defsrc caps a s d f g h j k l scln q w e r t y u i o p)
          (defalias
           caps (tap-hold 100 100 esc (layer-while-held numbers)))
          (deflayer base @caps a s d f g h j k l scln q w e r t y u i o p)
          (deflayer numbers _ 1 2 3 4 5 6 7 8 9 0
           S-1 S-2 S-3 S-4 S-5 S-6 S-7 S-8 S-9 S-0)
        '';
      };
    };
    tor = {
      enable = true;
      client.enable = true;
      settings = {
        HTTPTunnelPort = 9080;
      };
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };

  systemd = {
    services = {
      refresh-nps-cache = {
        path = [ "/run/current-system/sw/" ];
        serviceConfig = {
          Type = "oneshot";
          User = "jroid";
        };
        script = ''
          set -eu
          echo "Start refreshing nps cache"
          ${pkgs.nps}/bin/nps -r -dddd -e
          echo "finished nps cache with exit code $?."
        '';
      };
      tor.wantedBy = lib.mkForce [ ];
    };
    timers = {
      refresh-nps-cache = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "weekly";
          Persistent = true;
          Unit = "refresh-nps-cache.service";
        };
      };
    };
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
