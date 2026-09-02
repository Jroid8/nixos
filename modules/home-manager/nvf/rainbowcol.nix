{ lib, config, ... }:
let
	/*nixfmt:disable*/
  hsvToRgb = { h, s, v }:
    let
      h6 = h * 6;
      i = builtins.floor h6;
      f = h6 - i;
      p = v * (1 - s);
      q = v * (1 - s * f);
      t = v * (1 - s * (1 - f));
      rgb = builtins.elemAt [
        { r = v; g = t; b = p; }
        { r = q; g = v; b = p; }
        { r = p; g = v; b = t; }
        { r = p; g = q; b = v; }
        { r = t; g = p; b = v; }
        { r = v; g = p; b = q; }
      ] i;
      to255 = x: builtins.floor (255 * x + 0.5);
    in lib.mapAttrs (_: to255) rgb;
	inherit (lib) toHexString;
	rgbToHex = {r, g, b}: "#${toHexString(r)}${toHexString(g)}${toHexString(b)}";
	hsvToRgbHex = rgb: rgbToHex (hsvToRgb rgb);
	/*nixfmt:enable*/
  cfg = config.custom.nvf;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.highlight = builtins.listToAttrs (
      builtins.map (i: {
        name = "rainbowcol${builtins.toString i}";
        value = {
          fg = hsvToRgbHex {
            h = i / 6.0;
            s = 0.35;
            v = 0.8;
          };
        };
      }) (lib.lists.range 0 5)
    );
  };
}
