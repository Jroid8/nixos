{ pkgs, ... }: {
  fonts.fontconfig = {
    antialiasing = true;
    defaultFonts = {
      serif = [
        "Liberation Serif"
        "Vazirmatn"
      ];
      sansSerif = [
        "Ubuntu Sans"
        "Vazirmatn"
      ];
      monospace = [ "Ubuntu Sans Mono" ];
    };
  };
  home.packages = with pkgs; [
    vazir-fonts
    ubuntu-sans
    ubuntu-sans-mono
    nerd-fonts.jetbrains-mono
  ];
}
