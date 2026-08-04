{ pkgs, inputs, ... }: {
  programs.mpv = {
    enable = true;
    package = pkgs.mpv.override {
      inherit (inputs.self.packages) mpv-unwrapped;
      scripts = [ pkgs.mpvScripts.mpris ];
    };
    config = {
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
  };
}
