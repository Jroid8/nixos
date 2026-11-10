{ dag, ... }: {
  luaFiles = [
    ./keymaps.lua
    ./options.lua
  ];

  initLuaDag.leader-key-assign = dag.entryBefore [
    "lzn-load"
  ] /* lua */ ''vim.g.mapleader = " "'';
}
