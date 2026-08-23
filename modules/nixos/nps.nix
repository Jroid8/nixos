{ pkgs, ... }: {
  environment = {
    systemPackages = [ pkgs.nps ];
    shellAliases = {
      nps = "nps -e";
    };
  };
  systemd = {
    services.refresh-nps-cache = {
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
}
