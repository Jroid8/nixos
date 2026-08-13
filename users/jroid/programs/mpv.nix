{
  pkgs,
  inputs,
  ...
}:
{
  programs.mpv = {
    enable = true;
    package = pkgs.mpv.override {
      inherit (inputs.self.packages) mpv-unwrapped;
      scripts = [ pkgs.mpvScripts.mpris ];
    };
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
}
