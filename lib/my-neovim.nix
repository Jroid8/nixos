{
  mnw,
  pkgs,
  import-tree,
}:
let
  inherit (pkgs) lib;
in
mnw.lib.wrap pkgs (
  { config, ... }:
  {
    imports = [
      (import-tree ../modules/mnw)
    ];

    config = {
      appName = "nvim";
      plugins = {
        start = with pkgs.vimPlugins; [
          lz-n
          plenary-nvim
        ];
      };
    };
  }
)
