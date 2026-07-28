{
  imports = [
    ./mpd.nix
  ];
  services = {
    cliphist = {
      enable = true;
      extraOptions = [
        "-max-dedupe-search"
        "10"
        "-max-items"
        "100"
      ];
    };
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
      acceleration = "cuda";
    };
    ssh-agent.enable = true;
    playerctld.enable = true;
  };
}
