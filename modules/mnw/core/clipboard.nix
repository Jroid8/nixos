{ pkgs, ... }: {
  extraBinPath = [ pkgs.wl-clipboard ];
  initLua = /* lua */ ''
    vim.o.clipboard = "unnamedplus"
  '';
}
