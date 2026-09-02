{ config, lib, ... }:
let
  cfg = config.custom.mpd;
in
{
  options = {
    custom.mpd.enable = lib.mkEnableOption "customized kitty";
  };
  config = lib.mkIf cfg.enable {
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
  };
}
