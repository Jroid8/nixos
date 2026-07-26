{ pkgs, ... }: {
  programs.mpv = {
    config = {
      vo = "vaapi";
      sid = "no";
      hwdec = "auto";
      ao = "pipewire";
      audio-channels = "auto";
      save-position-on-quit = true;
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      tscale = "oversample";
      input-ipc-server = "/tmp/mpvipc";
      volume-max = 200;
    };
    scriptOpts = {
      osc = {
        timems = true;
      };
    };
    profiles = {
      gpu = {
        vo = "gpu";
        profile = "gpu-hq";
        hwdec = "nvdec";
      };
    };
    scripts = [ pkgs.mpvScripts.mpris ];
  };
}
