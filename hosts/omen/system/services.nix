{
  custom = {
    tor.enable = true;
    nix-gc.enable = true;

    nbfc = {
      enable = true;
      omen16-b0xxx-patch = true;
    };
  };
  services = {
    tuned.enable = true;
    upower.enable = true;
    udisks2.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };
}
