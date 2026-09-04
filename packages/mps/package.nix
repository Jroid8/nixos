{
  lib,
  replaceVarsWith,
  runtimeShell,
  dmenu,
  mpc,
  coreutils,
  findutils,
}:
replaceVarsWith {
  name = "mps";
  src = ./mps.sh;
  dir = "bin";
  isExecutable = true;
  replacements = {
    inherit runtimeShell;
    path = lib.makeBinPath [
      dmenu
      mpc
      coreutils
      findutils
    ];
  };
}
