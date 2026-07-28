{ config, ... }: {
  services.mpd-mpris.enable = true;
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    playlistDirectory = "/tmp/mpd-playlists/";
  };
  systemd.user.services = {
    mpd-playlists-dir = {
      Unit = {
        Description = "Create playlist directory of MPD";
        Before = "mpd.service";
      };
      Service = {
        Type = "exec";
        ExecStart = "mkdir /tmp/mpd-playlists";
      };
    };
    mps-init = {
      Unit = {
        Description = "Setup MPD";
        After = "mpd.service";
      };
      Service = {
        Type = "exec";
        ExecStart = "${config.custom-pkgs.mps}";
      };
    };
  };
}
