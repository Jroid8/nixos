{
  custom = {
    autoExpire.enable = true;
    mpd.enable = true;
    tor.enable = true;
    wl-clip-persist.enable = true;

    ollama = {
      enable = true;
      acceleration = "cuda";
    };
  };
  services = {
    playerctld.enable = true;
  };
}
