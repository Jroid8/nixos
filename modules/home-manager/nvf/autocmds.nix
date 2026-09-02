{ lib, config, ... }:
let
  cfg = config.custom.nvf;
  inherit (lib.generators) mkLuaInline;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.autocmds = [
      {
        event = [ "BufRead" ];
        pattern = [ "*" ];
        callback = mkLuaInline /* lua */ ''
          function()
          	local l1 = vim.fn.getline(1)
          	if l1:match("rust-script") then
          		vim.bo.filetype = "rust"
          	end
          end
        '';
      }
      {
        event = [ "FileType" ];
        pattern = [
          "asm"
          "nasm"
        ];
        callback = mkLuaInline /* lua */ ''
          function()
          	vim.bo.tabstop = 8
          	vim.bo.shiftwidth = 8
          end
        '';
      }
      {
        event = [ "FileType" ];
        pattern = [ "fish" ];
        callback = mkLuaInline /* lua */ ''
          function()
          	vim.bo.tabstop = 4
          	vim.bo.shiftwidth = 4
          	vim.bo.expandtab = true
          end
        '';
      }
    ];
  };
}
