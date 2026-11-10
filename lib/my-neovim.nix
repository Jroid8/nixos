{
  mnw,
  pkgs,
  import-tree,
  dag,
}:
let
  inherit (pkgs) lib;
  dag-lib = dag.lib { inherit lib; };
in
mnw.lib.wrap pkgs (
  { config, ... }:
  {
    imports = [
      (import-tree ../modules/mnw)
    ];

    options = {
      initLuaDag = lib.mkOption {
        default = { };
        type = dag-lib.of lib.types.str;
      };
    };

    config = {
      _module.args = {
        dag = dag-lib;
      };

      appName = "nvim";

      initLua = dag-lib config.initLuaDag;

      plugins = {
        start = with pkgs.vimPlugins; [
          lz-n
          plenary-nvim
        ];
      };
    };
  }
)
