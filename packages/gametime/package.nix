{
  lib,
  replaceVarsWith,
  fish,
  coreutils,
  systemd,
  gamemode,
}:
replaceVarsWith {
  name = "gametime";
  src = ./gametime.fish;
  dir = "bin";
  isExecutable = true;
  replacements = {
    fish = lib.getExe fish;
    path = lib.makeBinPath [
      coreutils
      systemd
      gamemode
    ];
  };
}
