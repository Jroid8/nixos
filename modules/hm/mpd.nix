{ config, ... }: {
  services.mpd-mpris.enable = true;
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    playlistDirectory = "${config.xdg.dataHome}/mpd/playlists/";
    extraConfig = ''
      audio_output {
      	type "pipewire"
      	name "MPD Output"
      }
    '';
  };
}
