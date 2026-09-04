{
  lib,
  replaceVarsWith,
  fish,
  rofi,
}:
replaceVarsWith {
  name = "game-selector";
  src = ./game-selector.fish;
  dir = "bin";
  isExecutable = true;
  replacements = {
    fish = lib.getExe fish;
    rofi = lib.getExe (
      rofi.override (_: {
        theme = replaceVarsWith {
          name = "game-selector-theme.rasi";
          src = ./game-selector-rofi.rasi;
          replacements = {
            mytheme = ../programs/rofi/mytheme.rasi;
          };
        };
      })
    );
  };
}
