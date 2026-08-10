{ pkgs-cuda, ... }: {
  imports = [
    ./mpd.nix
  ];
  services = {
    wl-clip-persist = {
      enable = true;
      extraOptions = [
        "--selection-size-limit"
        "52428800"
      ];
    };
    home-manager.autoExpire = {
      enable = true;
      frequency = "weekly";
      store = {
        cleanup = true;
        options = "--delete-older-than 7d";
      };
      timestamp = "-7 days";
    };
    ollama = {
      enable = true;
      package = pkgs-cuda.ollama;
    };
    ssh-agent.enable = true;
    playerctld.enable = true;
  };
}
