{ pkgs, dag, ... }: {
  extraBinPath = [ pkgs.wl-clipboard ];
  initLuaDag.clipboard-assign = dag.entryAnywhere /* lua */ ''
    vim.o.clipboard = "unnamedplus"
  '';
}
