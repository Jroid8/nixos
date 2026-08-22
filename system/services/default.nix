{ lib, pkgs, ... }: {
  imports = [ ./nbfc.nix ];

  services = {
    tuned.enable = true;
    upower.enable = true;
    udisks2.enable = true;
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
