{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.ts-textobjects;
  keyTextobjPairs = [
    {
      key = "c";
      textobj = "call";
    }
    {
      key = "C";
      textobj = "class";
    }
    {
      key = "f";
      textobj = "function";
    }
    {
      key = "l";
      textobj = "loop";
    }
  ];
  selectKeys =
    (
      keyTextobjPairs
      |> builtins.concatMap (
        { key, textobj }:
        let
          mode = [
            "x"
            "o"
          ];
        in
        [
          {
            inherit mode;
            key = "a" + key;
            action = lib.mkLuaInline /* lua */ ''
              function()
                require("nvim-treesitter-textobjects.select").select_textobject("@${textobj}.outer", "textobjects")
              end
            '';
          }
          {
            inherit mode;
            key = "i" + key;
            action = lib.mkLuaInline /* lua */ ''
              function()
                require("nvim-treesitter-textobjects.select").select_textobject("@${textobj}.inner", "textobjects")
              end
            '';
          }
        ]
      )
    )
    ++ [
      {
        mode = [
          "x"
          "o"
        ];
        key = "aal";
        action = lib.mkLuaInline /* lua */ ''
          function()
            require("nvim-treesitter-textobjects.select").select_textobject("@assignment.lhs", "textobjects")
          end
        '';
      }
      {
        mode = [
          "x"
          "o"
        ];
        key = "aar";
        action = lib.mkLuaInline /* lua */ ''
          function()
            require("nvim-treesitter-textobjects.select").select_textobject("@assignment.rhs", "textobjects")
          end
        '';
      }
    ];
  moveKeys =
    keyTextobjPairs
    |> builtins.concatMap (
      { key, textobj }:
      let
        mode = [
          "n"
          "x"
          "o"
        ];
      in
      [
        {
          inherit mode;
          key = "]" + key;
          action = lib.mkLuaInline /* lua */ ''
            function()
              require("nvim-treesitter-textobjects.move").goto_next_start("@${textobj}.outer", "textobjects")
            end
          '';
        }
        {
          inherit mode;
          key = "[" + key;
          action = lib.mkLuaInline /* lua */ ''
            function()
              require("nvim-treesitter-textobjects.move").goto_previous_start("@${textobj}.outer", "textobjects")
            end
          '';
        }
      ]
    );

in
{
  options = {
    custom.ts-textobjects = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    plugins.opt = [ pkgs.vimPlugins.nvim-treesitter-textobjects ];
    lz-n = [
      {
        name = "nvim-treesitter-textobjects";
        after = lib.mkLuaInline /* lua */ ''
          function()
            require("nvim-treesitter-textobjects").setup()
            local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
          end
        '';
        keys = selectKeys ++ moveKeys;
      }
    ];
  };
}
