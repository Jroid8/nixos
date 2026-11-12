{
  lib,
  config,
  dag,
  ...
}:
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
	/*nixfmt:enable*/
  setHlGroupsLua =
    lib.lists.range 0 (cfg.count - 1)
    |> builtins.map (
      i:
      let
        name = "rainbowcol${builtins.toString i}";
        color =
          {
            h = i / 6.0;
            s = 0.4;
            v = 0.8;
          }
          |> hsvToRgb
          |> rgbToHex;
      in
      ''vim.api.nvim_set_hl(0, "${name}", {fg="${color}"})''
    )
    |> lib.join "\n\t";
  rainbowHlsListLua =
    lib.lists.range 0 (cfg.count - 1)
    |> builtins.map (i: "rainbowcol${builtins.toString i}")
    |> lib.generators.toLua { multiline = false; };
  cfg = config.custom.rainbowcol;
in
{
  options = {
    custom.rainbowcol = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      count = lib.mkOption {
        type = lib.types.int;
        default = 6;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    initLuaDag.rainbowcol-highlights = dag.entryBefore [ "colorscheme" ] /* lua */ ''
      local function set_rainbow_hl_groups()
        ${setHlGroupsLua}
      end
      local rainbow_hl_groups = ${rainbowHlsListLua}
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = set_rainbow_hl_groups
      })
    '';
  };
}
