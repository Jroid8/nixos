{ pkgs, ... }:
let
  enableCuda = pkgs.config // {
    cudaCapabilities = [
      "8.6"
      "8.0"
    ];
    cudaForwardCompat = true;
    cudaSupport = true;
  };
in
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        ollama-cuda = prev.ollama-cuda.override { config = enableCuda; };
        ffmpeg-full = prev.ffmpeg-full.override {
          config = enableCuda;
          withNvcodec = true;
          withUnfree = true;
        };
        mpv-unwrapped = prev.mpv-unwrapped.override { ffmpeg = final.ffmpeg-full; };
      })
    ];
    config.allowUnfree = true;
  };
}
