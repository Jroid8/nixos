{
  lib,
  pkgs,
  config,
  dag,
  ...
}:
{
  options = {
    lsp.lua-ls = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.lsp.lua-ls {
    extraBinPath = [ pkgs.lua-language-server ];
    initLuaDag.lua-lsp-config = dag.entryAnywhere /* lua */ ''
      vim.lsp.config("lua_ls", {
        root_markers = { ".nvim-config" },
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if not vim.uv.fs_stat(path .. "/.nvim-config") then return end
          end
          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            workspace = {
              checkThirdParty = false,
              library = { "${config.neovim}/share/nvim/runtime/lua" },
            },
          })
        end
      })
      vim.lsp.enable("lua_ls")
    '';
  };
}
