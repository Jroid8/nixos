{
  lib,
  replaceVarsWith,
  runtimeShell,
	dmenu,
  dmenuCmd ? lib.getExe dmenu,
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
    inherit runtimeShell dmenuCmd;
    path = lib.makeBinPath [
      mpc
      coreutils
      findutils
    ];
  };
  meta.mainProgram = "mps";
}
