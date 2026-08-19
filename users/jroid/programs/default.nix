{ pkgs, config, ... }: {
  imports = [
    ./librewolf
    ./hyprland
    ./neovim
    ./noctalia
    ./qutebrowser
    ./rofi
    ./yazi
    ./equibop.nix
    ./feh.nix
    ./fish.nix
    ./git.nix
    ./kitty.nix
    ./mpv.nix
    ./v2rayn.nix
    ./yt-dlp.nix
    ./zathura.nix
  ];
  programs = {
    bash.enable = true;
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
    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
  };
}
