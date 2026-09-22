{
  pkgs,
  config,
  lib,
  pkgs-cuda,
  ...
}:
let
  cfg = config.custom.mpd;
  pkg = pkgs.mpv.override {
    mpv-unwrapped =
      if cfg.cuda then
        pkgs-cuda.mpv-unwrapped.override {
          ffmpeg = pkgs-cuda.ffmpeg-full.override {
            withNvcodec = true;
          };
        }
      else
        pkgs.mpv-unwrapped;
    scripts = [ pkgs.mpvScripts.mpris ];
  };
in
{
  options = {
    custom.mpv = {
      enable = lib.mkEnableOption "customized mpv";
      cuda = lib.mkEnableOption "mpv with cuda";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      package = pkg;
      config = {
        hwdec = "auto";

        ao = "pipewire";
        sid = "no";
        volume-max = 200;

        input-ipc-server = "/tmp/mpvipc";
        save-position-on-quit = true;

        ytdl = true;
        ytdl-format = "bv[height<=720][fps<=?30]+ba[abr<=?95][language*=?en]/bv[height<=720]+ba[language*=?en]";
      };
      scriptOpts = {
        osc = {
          timems = true;
        };
      };
    };
    xdg.mimeApps.defaultApplicationPackages = [ pkg ];
  };
}
