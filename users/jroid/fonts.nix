{ pkgs, ... }: {
  fonts.fontconfig = {
    antialiasing = true;
    defaultFonts = {
      serif = [
        "Liberation Serif"
        "Vazirmatn"
      ];
      sansSerif = [
        "Ubuntu"
        "Vazirmatn"
      ];
      monospace = [ "Ubuntu Mono" ];
    };
  };
  home.packages = with pkgs; [
    vazir-fonts
    ubuntu-sans
    ubuntu-sans-mono
    nerd-fonts.jetbrains-mono
  ];
}
