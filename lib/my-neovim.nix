{
  mnw,
  pkgs,
  import-tree,
}:
let
  inherit (pkgs) lib;
  inherit (lib) types;
  luaInlineOr = types.either types.luaInline;
  strList = types.listOf types.nonEmptyStr;
  oneStrOrList = types.either types.nonEmptyStr (types.listOf types.nonEmptyStr);
  toLua = lib.generators.toLua { multiline = false; };
  eventPattern = types.submodule {
    options = {
      event = lib.mkOption {
        type = types.nullOr oneStrOrList;
        default = null;
      };
      pattern = lib.mkOption {
        type = types.nullOr oneStrOrList;
        default = null;
      };
    };
  };
  lznKeysSpec = types.submodule {
    options = {
      key = lib.mkOption {
        type = types.nonEmptyStr;
      };
      action = lib.mkOption {
        type = types.nullOr (luaInlineOr types.nonEmptyStr);
        default = null;
      };
      mode = lib.mkOption {
        type = types.nullOr oneStrOrList;
        default = null;
      };
      desc = lib.mkOption {
        type = types.nullOr types.str;
        default = null;
      };
      noremap = lib.mkOption {
        type = types.nullOr types.bool;
        default = null;
      };
      remap = lib.mkOption {
        type = types.nullOr types.bool;
        default = null;
      };
      expr = lib.mkOption {
        type = types.nullOr types.bool;
        default = null;
      };
      nowait = lib.mkOption {
        type = types.nullOr types.bool;
        default = null;
      };
      ft = lib.mkOption {
        type = types.nullOr oneStrOrList;
        default = null;
      };
      silent = lib.mkOption {
        type = types.nullOr types.bool;
        default = null;
      };
    };
  };
  lznKeysToLua =
    e:
    ''{"${e.key}",${toLua e.action},${
      builtins.mapAttrs (k: v: "${k} = ${toLua v}") (
        lib.filterAttrs (k: v: v != null && k != "key" && k != "action") e
      )
      |> builtins.attrValues
      |> lib.join ","
    }}'';
  lznPluginSpec = types.submodule {
    options = {
      name = lib.mkOption {
        type = types.nonEmptyStr;
      };
      enabled = lib.mkOption {
        type = types.nullOr (luaInlineOr types.bool);
        default = null;
      };
      beforeAll = lib.mkOption {
        type = types.nullOr types.luaInline;
        default = null;
      };
      before = lib.mkOption {
        type = types.nullOr types.luaInline;
        default = null;
      };
      after = lib.mkOption {
        type = types.nullOr types.luaInline;
        default = null;
      };
      event = lib.mkOption {
        type = types.nullOr (
          types.oneOf [
            eventPattern
            strList
            types.nonEmptyStr
          ]
        );
        default = null;
      };
      cmd = lib.mkOption {
        type = types.nullOr oneStrOrList;
        default = null;
      };
      ft = lib.mkOption {
        type = types.nullOr oneStrOrList;
        default = null;
      };
      keys = lib.mkOption {
        type = types.nullOr (types.listOf lznKeysSpec);
        default = null;
      };
      colorscheme = lib.mkOption {
        type = types.nullOr oneStrOrList;
        default = null;
      };
      lazy = lib.mkOption {
        type = types.nullOr types.bool;
        default = null;
      };
      priority = lib.mkOption {
        type = types.nullOr types.int;
        default = null;
      };
      load = lib.mkOption {
        type = types.nullOr types.luaInline;
        default = null;
      };
    };
  };
  lznPluginSpecToLua =
    p:
    ''{"${p.name}",${
      if p.keys != null then "keys = {${builtins.map lznKeysToLua p.keys |> lib.join ","}}," else ""
    }${
      builtins.mapAttrs (k: v: "${k} = ${toLua v}") (
        lib.filterAttrs (k: v: v != null && k != "name" && k != "keys") p
      )
      |> builtins.attrValues
      |> lib.join ","
    }}'';
in
mnw.lib.wrap pkgs (
  { config, ... }:
  {
    imports = [
      (import-tree ../modules/mnw)
    ];

    options = {
      lz-n = lib.mkOption {
        default = [ ];
        type = lib.types.listOf lznPluginSpec;
      };
    };

    config = {
      appName = "nvim";

      initLua = /* lua */ ''
        vim.g.mapleader = " ";
        require("lz.n").load({
          ${builtins.map lznPluginSpecToLua config.lz-n |> lib.join ",\n"}
        })
      '';

      plugins = {
        start = with pkgs.vimPlugins; [
          lz-n
          plenary-nvim
        ];
        dev._config = {
          pure = ./.;
          impure = builtins.toString ./.;
        };
      };
    };
  }
)
