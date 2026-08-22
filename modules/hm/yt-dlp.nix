{ lib, pkgs, ... }: {
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
      proxy = "socks5://localhost:9050";
      remote-components = "ejs:github";
      retry-sleep = 5;
      sponsorblock-remove = "filler,sponsor";
      sub-langs = "en.*,-live_chat";
      write-thumbnail = true;
    };
  };
}
