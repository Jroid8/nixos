{ pkgs, config, ... }: {
  programs.rbw = {
    enable = true;
    settings = {
      email = "jroid8@tutanota.com";
      pinentry = pkgs.pinentry-rofi.override (_: {
        rofi = config.custom-pkgs.rofi;
      });
    };
  };
}
