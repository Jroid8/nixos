{ config, ... }: {
  services.mpd-mpris.enable = true;
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    playlistDirectory = "${config.xdg.dataHome}/mpd/playlists/";
  };
  systemd.user.services = {
    mps-init = {
      Unit = {
        Description = "Setup MPD";
        After = "mpd.service";
      };
      Service = {
        Type = "exec";
        ExecStart = "${config.custom-pkgs.mps} init";
      };
    };
  };
}
