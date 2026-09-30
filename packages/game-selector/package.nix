{
  lib,
  fish,
  rofi,
  runCommandLocal,
}:
let
  src = ./game-selector.fish;
  mainTheme = ../themed-rofi/mytheme.rasi;
  gsTheme = ./game-selector-rofi.rasi;
in
runCommandLocal "game-selector"
  {
    meta = {
      mainprogram = "game-selector";
    };
  }
  /* bash */ ''
    mkdir -p $out/share/rofi
    cp ${mainTheme} $out/share/rofi/mytheme.rasi
    substitute ${gsTheme} $out/share/rofi/game-selector.rasi \
    	--subst-var-by mytheme $out/share/rofi/mytheme.rasi

    mkdir -p $out/bin
    substitute ${src} $out/bin/game-selector \
    	--subst-var-by rofi "${lib.getExe rofi} -theme $out/share/rofi/game-selector.rasi" \
    	--subst-var-by fish "${lib.getExe fish}"
    chmod +x $out/bin/game-selector
  ''
