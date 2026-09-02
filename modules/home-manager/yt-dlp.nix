{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.custom.yt-dlp;
in
{
  options = {
    custom.yt-dlp.enable = lib.mkEnableOption "customized yt-dlp";
  };
  config = lib.mkIf cfg.enable {
    programs.yt-dlp = {
      enable = true;
      settings = {
        audio-format = "mp3";
        embed-chapters = true;
        embed-metadata = true;
        embed-subs = true;
        js-runtimes = "deno:${lib.getExe pkgs.deno}";
        match-filters = "!was_live";
        merge-output-format = "mp4/mkv";
        no-write-auto-subs = true;
        output = "%(fulltitle)s.%(ext)s";
        remote-components = "ejs:github";
        retry-sleep = 5;
        sponsorblock-remove = "filler,sponsor";
        sub-langs = "en.*,-live_chat";
        write-thumbnail = true;
      };
    };
  };
}
