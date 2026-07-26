{
  imports = [
    ./hyprland
    ./neovim
    ./noctalia
    ./rofi
    ./yazi
    ./zen-browser
    ./equibop.nix
    ./fish.nix
    ./git.nix
    ./kitty.nix
    ./mpv.nix
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
    feh = {
      enable = true;
      keybindings = {
        scroll_up = "k";
        scroll_down = "j";
        scroll_left = "h";
        scroll_right = "l";
        zoom_in = "u";
        zoom_out = "d";
        zoom_default = "C-z";
        zoom_fit = "z";

        next_img = "i";
        prev_img = "o";

        delete = "D";

        menu_parent = [
          "h"
          "Left"
        ];
        menu_child = [
          "l"
          "Right"
        ];
        menu_down = [
          "j"
          "Down"
        ];
        menu_up = [
          "k"
          "Up"
        ];
        menu_select = [
          "space"
          "Return"
        ];
      };
    };
  };
}
