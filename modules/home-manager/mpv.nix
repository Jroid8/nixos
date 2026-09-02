{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.mpd;
  pkg = pkgs.mpv.override {
    inherit (inputs.self.packages) mpv-unwrapped;
    scripts = [ pkgs.mpvScripts.mpris ];
  };
in
{
  options = {
    custom.mpd.enable = lib.mkEnableOption "customized kitty";
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
