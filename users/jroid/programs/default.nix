{ pkgs, config, ... }: {
  imports = [
    ./hyprland
    ./neovim
    ./noctalia
    ./rofi
    ./yazi
    ./qutebrowser
    ./equibop.nix
    ./fish.nix
    ./git.nix
    ./kitty.nix
    ./mpv.nix
    ./yt-dlp.nix
  ];
  programs = {
    bash = {
      enable = true;
      shellAliases = import ./aliases.nix;
    };
    eza = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      colors = "auto";
      icons = "auto";
      extraOptions = [ "--no-quotes" ];
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      defaultOptions = [ "--color=hl:#00ff00,hl+:#00ff00" ];
    };
    rbw = {
      enable = true;
      settings = {
        email = "jroid8@tutanota.com";
        pinentry = pkgs.pinentry-rofi.override (_: {
          rofi = config.custom-pkgs.rofi;
        });
      };
    };
  };
}
