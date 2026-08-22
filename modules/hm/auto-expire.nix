{
  services.home-manager.autoExpire = {
    enable = true;
    frequency = "weekly";
    store = {
      cleanup = true;
      options = "--delete-older-than 7d";
    };
    timestamp = "-7 days";
  };
}
