{ config, ... }: {
  systemd.user.services.mpd-playlists-dir = {
    Unit = {
      Description = "Create playlist directory of MPD";
      Before = "mpd.service";
    };
    Service = {
      Type = "exec";
      ExecStart = "mkdir /tmp/mpd-playlists";
    };
  };
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    playlistDirectory = "/tmp/mpd-playlists/";
  };
  services.mpd-mpris.enable = true;
  systemd.user.services.mps-init = {
    Unit = {
      Description = "Setup MPD";
      After = "mpd.service";
    };
    Service = {
      Type = "exec";
      ExecStart = "${config.custom-pkgs.mps}";
    };
  };
}
