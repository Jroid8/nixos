{ dag, ... }: {
  luaFiles = [
    ./keymaps.lua
    ./options.lua
  ];

  initLuaDag.leader-key-assign = dag.entryAnywhere /* lua */ ''vim.g.mapleader = " "'';
}
